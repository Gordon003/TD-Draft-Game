//Check character's info
function CharInfoSelect(e:MouseEvent):void{
	var D: String = Char;
	Char = e.currentTarget.PlayerName;
	
	trace(Char);
	
	//Remove select glow effect
	for (var K: int = 0; K <  TeamCard.length; K++){
		TeamCard[K].addEventListener(MouseEvent.MOUSE_OVER, Hover);
		TeamCard[K].addEventListener(MouseEvent.MOUSE_OUT, Leave);
		TeamCard[K].filters = [];
	}
	
	//If same player then it deselect that character
	if (D == Char){
		e.currentTarget.filters = [];
		Char = "";
		btnInfo.Invisible();
		btnSwap.Invisible();
	}
	//If not, then it selects that player
	else {
		e.currentTarget.filters = [ButtonSelected];
		e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, Hover);
		e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, Leave);
		e.currentTarget.addEventListener(MouseEvent.MOUSE_OVER, HoverSelected);
		e.currentTarget.addEventListener(MouseEvent.MOUSE_OUT, LeaveSelected);
		btnInfo.Visible();
		if (Char != Team[0]){
			btnSwap.Visible();
		}
		else {
			btnSwap.Invisible();
		}
	}
};

btnHelp.addEventListener(MouseEvent.CLICK, Help);
function Help(e:MouseEvent):void{
	FormHelp.visible = true;
}

btnSwap.addEventListener(MouseEvent.CLICK, Swap);
function Swap(e:MouseEvent):void{
	TeamName.text = "Who do u want to swap with?";
	
	//Leader can't be swapped
	TeamCard[0].removeEventListener(MouseEvent.MOUSE_OVER, Hover);
	TeamCard[0].removeEventListener(MouseEvent.MOUSE_OUT, Leave);
	TeamCard[0].removeEventListener(MouseEvent.CLICK, CharInfoSelect);
	
	for (var K: int = 1; K <  TeamCard.length; K++){
		TeamCard[K].removeEventListener(MouseEvent.CLICK, CharInfoSelect);
		if (TeamCard[K].PlayerInfo[0] == "None" || TeamCard[K].PlayerName == Char){
			TeamCard[K].removeEventListener(MouseEvent.MOUSE_OVER, Hover);
			TeamCard[K].removeEventListener(MouseEvent.MOUSE_OUT, Leave);
		}
		else{
			TeamCard[K].addEventListener(MouseEvent.CLICK, SwapPick);
		}
	}
	
	btnSwap.lblTitle.text = "Cancel";
	btnSwap.removeEventListener(MouseEvent.CLICK, Swap);
	btnSwap.addEventListener(MouseEvent.CLICK, CancelSwap);
}

function SwapPick(e:MouseEvent):void{
	e.currentTarget.filters = [ButtonSelected];
	e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, Hover);
	e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, Leave);
	SecondChar = e.currentTarget.PlayerName;
	
	TeamName.text = "Confirm Swap?";
	btnInfo.lblTitle.text = "Yes";
	btnSwap.lblTitle.text = "No";
	
	btnInfo.Visible();
	btnInfo.removeEventListener(MouseEvent.CLICK, AppearInfo);
	btnInfo.addEventListener(MouseEvent.CLICK, ConfirmSwap);
}

function ConfirmSwap(e:MouseEvent):void{
	for (var K: int = 0; K <  TeamCard.length; K++){
		if (TeamCard[K].PlayerName == Char){
			TeamCard[K].PlayerName = SecondChar;
			TeamCard[K].PlayerInfo = CharacterInfo[SecondChar];
			TeamCard[K].PlayerRating = CharacterRating[SecondChar];
			TeamCard[K].Refresh();
			TeamCard[K].Load(SecondChar)
		}
		else if (TeamCard[K].PlayerName == SecondChar){
			TeamCard[K].PlayerName = Char;
			TeamCard[K].PlayerInfo = CharacterInfo[Char];
			TeamCard[K].PlayerRating = CharacterRating[Char];
			TeamCard[K].Refresh();
			TeamCard[K].Load(Char)
		}
		
		//Return back to normal
		TeamCard[K].removeEventListener(MouseEvent.CLICK, SwapPick);
		TeamCard[K].addEventListener(MouseEvent.MOUSE_OVER, Hover);
		TeamCard[K].addEventListener(MouseEvent.MOUSE_OUT, Leave);
		TeamCard[K].filters = [];
		if (TeamCard[K].PlayerName == "None"){
		}
		else {
			TeamCard[K].addEventListener(MouseEvent.CLICK, CharInfoSelect);
		}
	}
	
	//Recalculate Chemistry
	for (var f: int = 0; f < TeamCard.length; f++){
		if (TeamCard[f].PlayerName != "None"){
			//Calculate chemistry for individual characters
			CalculateChemistry(f);
			Chem[f].text = "Chem: " + TeamCard[f].PlayerChemistry;
		}
	}
	
	//Restart
	btnInfo.addEventListener(MouseEvent.CLICK, AppearInfo);
	btnInfo.removeEventListener(MouseEvent.CLICK, ConfirmSwap);
	btnInfo.lblTitle.text = "Info";
	btnInfo.Invisible();
	
	btnSwap.removeEventListener(MouseEvent.CLICK, ConfirmSwap);
	btnSwap.addEventListener(MouseEvent.CLICK, Swap);
	btnSwap.lblTitle.text = "Swap";
	btnSwap.Invisible();
	
	TeamName.text = "Team: " + TeamInfo[0];
	Char = "";
}

function CancelSwap(e:MouseEvent):void{
	for (var K: int = 0; K <  TeamCard.length; K++){
		//Return back to normal
		if (TeamCard[K].PlayerName == "None" ){
		}
		else {
			TeamCard[K].addEventListener(MouseEvent.CLICK, CharInfoSelect);
		}
		TeamCard[K].removeEventListener(MouseEvent.CLICK, SwapPick);
		TeamCard[K].addEventListener(MouseEvent.MOUSE_OVER, Hover);
		TeamCard[K].addEventListener(MouseEvent.MOUSE_OUT, Leave);
		TeamCard[K].filters = [];
		
		if (TeamCard[K].PlayerName == Char){
			TeamCard[K].filters = [ButtonSelected];
			TeamCard[K].removeEventListener(MouseEvent.MOUSE_OVER, Hover);
			TeamCard[K].removeEventListener(MouseEvent.MOUSE_OUT, Leave);
		}
	}
	
	btnInfo.addEventListener(MouseEvent.CLICK, AppearInfo);
	btnInfo.removeEventListener(MouseEvent.CLICK, ConfirmSwap);
	btnInfo.lblTitle.text = "Info";
	
	btnSwap.removeEventListener(MouseEvent.CLICK, ConfirmSwap);
	btnSwap.addEventListener(MouseEvent.CLICK, Swap);
	btnSwap.lblTitle.text = "Swap";
	
	TeamName.text = "Team: " + TeamInfo[0];
}