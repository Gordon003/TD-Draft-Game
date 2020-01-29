/*Click "Start" button to start the whole draft
	Open Name Form */
btnStart.addEventListener(MouseEvent.CLICK, startName);
import Objects.Draft.NameForm;
function startName(e:MouseEvent):void{
	btnStart.visible = false;
	var nameForm: NameForm = new NameForm;
	addChildAt(nameForm, numChildren);
	nameForm.x = 514.2;
	nameForm.y = 335.35;
}

/*Hiding Button
	Enable User to hide draft to see squad*/
btnHide.addEventListener(MouseEvent.CLICK, hideDraft);
function hideDraft(e:MouseEvent):void{
	 var Draft = this.getChildAt(numChildren-1);

	//If Draft screen is visible, then it disappear
	if (Draft.visible == true){
		Draft.visible = false;
		btnHide.lblTitle.text = "Show";
	}
	//If Draft screen is already invisible, then it reappears
	else {
		Draft.visible = true;
		btnHide.lblTitle.text = "Hide";
	}
}

/*Character Info Button
	Display Selected Character's Information*/
import Objects.Forms.CharInfo;
btnInfo.addEventListener(MouseEvent.CLICK, appearInfo);
function appearInfo(e:MouseEvent):void{
	//Remove any duplicate form
	removeDuplicateForm();
	
	var infoForm: CharInfo = new CharInfo();
	addChildAt(infoForm, numChildren);
	infoForm.x = 524.85;
	infoForm.y = 301.35;
	infoForm.height = 312.4;
	infoForm.width = 638.6;
	infoForm.gotoAndStop(1);
	infoForm.infoAppear(firstCharSelected);
	infoForm.name = "Appeared";
	formAppear = infoForm.name;
}

/*Summary button
	Shows summary and result of user's squad*/
import Objects.Draft.SummaryForm;
btnMakeTeam.addEventListener(MouseEvent.CLICK, appearResult);
function appearResult(e:MouseEvent):void{
	btnMakeTeam.Invisible();
	
	for (var K: int = 0; K <  teamCard.length; K++){
		userTeam.push(teamCard[K].player);
	}
	
	var summaryForm: SummaryForm = new SummaryForm();
	addChildAt(summaryForm, numChildren);
	summaryForm.x = 524.55;
	summaryForm.y = 329.85;
	summaryForm.height = 366.65;
	summaryForm.width = 660.1;
	summaryForm.gotoAndPlay(2);
}

/*End Draft Button
	Move to frame 5*/
btnEndDraft.addEventListener(MouseEvent.CLICK, endDraft);
function endDraft(e:MouseEvent):void{
	removeChildAt(numChildren - 1);
	gotoAndStop(4);
}

/*Help Button
	Tell user how to play*/
btnHelp.addEventListener(MouseEvent.CLICK, help);
function help(e:MouseEvent):void{
	removeDuplicateForm();
	var helpForm: DraftHelp = new DraftHelp();
	addChildAt(helpForm, numChildren);
	helpForm.x = 230;
	helpForm.y = 165;
	helpForm.height = 330;
	helpForm.width = 590;
	helpForm.name = "Appeared";
	formAppear = helpForm.name;
}

/*Swap Button
	Find in CharSelectSwap.as*/
btnSwap.addEventListener(MouseEvent.CLICK, swap);
//Decide which 2 characters should be swapped
function swap(e:MouseEvent):void{
	TeamName.text = "Who do u want to swap with?";
	
	btnSwap.Invisible();
	
	//Leader can't be swapped
	teamCard[0].removeEventListener(MouseEvent.MOUSE_OVER, teamCard[0].cardHover);
	teamCard[0].removeEventListener(MouseEvent.MOUSE_OUT, teamCard[0].cardLeave);
	teamCard[0].removeEventListener(MouseEvent.CLICK, teamCard[0].characterSelected);
	
	//Swap function for team cards
	for (var K: int = 1; K <  teamCard.length; K++){
		teamCard[K].removeEventListener(MouseEvent.CLICK, teamCard[K].appearDraft);
		teamCard[K].removeEventListener(MouseEvent.CLICK, teamCard[K].characterSelected);
		
		//If that teamcard either is the selected one or has no character
		if (teamCard[K].player == firstCharSelected || teamCard[K].player == "None"){
			//Remove Hover function to indicate that that can't be selected
			teamCard[K].removeEventListener(MouseEvent.MOUSE_OVER, teamCard[K].cardHover);
			teamCard[K].removeEventListener(MouseEvent.MOUSE_OUT, teamCard[K].cardLeave);
		}
		
		//If that teamcard has a character
		if (teamCard[K].player != "None"){
			//Then the user is allow to swap that character with the selected character
			teamCard[K].addEventListener(MouseEvent.CLICK, swapChar);
		}
	}
}

//Swap 2 characters around
function swapChar(e:MouseEvent):void{
	secondCharSelected = e.currentTarget.player
	
	for (var K: int = 0; K <  teamCard.length; K++){
		/*If that card has the first selected character
			The character that user wanted to swap with in the first place*/
		if (teamCard[K].player == firstCharSelected){
			//Swap with second selected chracter
			teamCard[K].player = secondCharSelected;
			teamCard[K].loadCharacter(secondCharSelected);
		}
		/*If that card has the first selected character
			The character that user select to swap with the first selected character*/
		else if (teamCard[K].player == secondCharSelected){
			teamCard[K].player = firstCharSelected;
			teamCard[K].loadCharacter(firstCharSelected);
		}
		
		//Team Cards return back to normal
		teamCard[K].removeEventListener(MouseEvent.CLICK, swapChar);
		teamCard[K].addEventListener(MouseEvent.MOUSE_OVER, teamCard[K].cardHover);
		teamCard[K].addEventListener(MouseEvent.MOUSE_OUT, teamCard[K].cardLeave);
		teamCard[K].filters = [];
		
		//If that card still hasn't got a player, then it return to default state
		if (teamCard[K].player == "None"){
			teamCard[K].addEventListener(MouseEvent.CLICK, teamCard[K].appearDraft);
		}
		else {
			teamCard[K].addEventListener(MouseEvent.CLICK, teamCard[K].characterSelected);
		}
		
		//Display Individual Chemistry (Refresh)
		chem[K].text = "Chem: " + teamCard[K].playerChemistry;
	}
	
	//TeamName return back to normal
	TeamName.text = "Team: " + userTeamName;
	
	//Remove Selected Character
	firstCharSelected = "";
	btnInfo.Invisible();	//Character Info Button
	btnSwap.Invisible();	//Swap Button
}

//Remove any Duplicate form
function removeDuplicateForm(){
	var formName = getChildAt(numChildren - 1).name;
	if (formName == "Appeared"){
		removeChildAt(numChildren - 1);
	}
}