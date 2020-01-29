Left.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
Left.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
Left.addEventListener(MouseEvent.CLICK, MoveLeft);
function MoveLeft(e:MouseEvent):void{
	Right.visible = true;
	NumPage -= 1
	lblPage.text = "Page " + NumPage;
	
	if (NumPage == 1){
		Left.visible = false;
	}
	
	var Page: Number = ((NumPage- 1) * 5)
	for (var F: int = 0; F < CardSearch.length; F++){
		CardSearch[F].Load(SortedResult[Page + F]);
		CardSearch[F].visible = true;
	};
	
	for (var K: int = 0; K < CardSearch.length; K++){
		CardSearch[K].filters = [];
	}
	btnInfo.visible = false;
	btnSelect.visible = false;
}

Right.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
Right.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
Right.addEventListener(MouseEvent.CLICK, MoveRight);
function MoveRight(e:MouseEvent):void{
	var AmountLeft: Number = SortedResult.length - (NumPage * 5);

	if (AmountLeft > 5){
		AmountLeft = 5;
	}
	else{
		Right.visible = false;
	}
	
	var Page: Number = (NumPage * 5)
	for (var F: int = 0; F < AmountLeft; F++){
		CardSearch[F].Load(SortedResult[Page + F]);
	};
	
	
	for (var G: int = AmountLeft; G < 5; G++){
		CardSearch[G].visible = false;
	};
	
	Left.visible = true;
	NumPage += 1
	lblPage.text = "Page " + NumPage;
	
	for (var K: int = 0; K < CardSearch.length; K++){
		CardSearch[K].filters = [];
	}
	btnInfo.visible = false;
	btnSelect.visible = false;
}

lblSeason.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
lblSeason.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
lblSeason.addEventListener(MouseEvent.CLICK, AppearSeason);
function AppearSeason(e:MouseEvent):void{
	Season.visible = true;
	Season.Load();
}

lblName.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
lblName.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
lblName.addEventListener(MouseEvent.CLICK, AppearName);
function AppearName(e:MouseEvent):void{
	NameForm.visible = true;
	NameForm.lblNameInput.text = "";
	for (var M: int = 0; M < 5; M++){
		NameForm.LabelList[M].visible = false;
	}
}

lblCardForm.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
lblCardForm.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
lblCardForm.addEventListener(MouseEvent.CLICK, ChangeCard);
function ChangeCard(e:MouseEvent):void{
	if (lblCardForm.text == "any"){
		lblCardForm.text = "Gold";
	}
	else if (lblCardForm.text == "Gold"){
		lblCardForm.text = "Silver";
	}
	else if (lblCardForm.text == "Silver"){
		lblCardForm.text = "Bronze";
	}
	else if (lblCardForm.text == "Bronze"){
		lblCardForm.text = "any";
	}
	CardFormSelected = lblCardForm.text;
}

btnInfo.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
btnInfo.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
btnInfo.addEventListener(MouseEvent.CLICK, AppearInfo);
function AppearInfo(e:MouseEvent):void{
	MovieClip(root).Info.InfoAppear(CharacterSelected);
}

btnSelect.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
btnSelect.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
btnSelect.addEventListener(MouseEvent.CLICK, MoveCharacter);
function MoveCharacter(e:MouseEvent):void{
	Card2.Load(CharacterSelected);
}