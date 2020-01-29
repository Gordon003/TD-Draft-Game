//Start next round/challenge
import Objects.Game.AnnounceForm;
btnNextChallenge.addEventListener(MouseEvent.CLICK, StartRound);
function StartRound(e:MouseEvent):void{
	e.currentTarget.visible = false;
	btnGameMenu.visible = false;
	if (challengeNumber == 1){
		userAction = "StartRound";
	}
	else{
		userAction = "StartChallenge";
	}
	
	//Display Announcement
	var formAnnouncer: AnnounceForm = new AnnounceForm();
	addChildAt(formAnnouncer, numChildren);
	formAnnouncer.x = 490;
	formAnnouncer.y = 285;
	formAnnouncer.height = 266.65;
	formAnnouncer.width = 400;
	formAnnouncer.gotoAndPlay(2);
}

//Confirm user selection
btnConfirm.addEventListener(MouseEvent.CLICK, confirmPlayer);
function confirmPlayer(e:MouseEvent):void{
	var numPlayerSelected: Number = 0;
	teamBattle["User"] = [];
	
	for (var a: int = 0; a < cardArray["Friend"].length; a++){
		if (cardArray["Friend"][a].selected == "true" && cardArray["Friend"][a].used == "false"){
			cardArray["Friend"][a].calculateScore();
			numPlayerSelected += 1;
			teamBattle["User"].push(cardArray["Friend"][a].player);
		}
	};
	
	if (numPlayerSelected != numPlayer){
		var stopForm: StopForm = new StopForm();
		addChildAt(stopForm, numChildren);
		stopForm.x = 500;
		stopForm.y = 295;
		stopForm.height = 266.65;
		stopForm.width = 400;
		btnConfirm.visible = false;
	}
	else{
		e.currentTarget.visible = false;
		for (var b: int = 0; b < cardArray["Friend"].length; b++){
			cardArray["Friend"][b].removeEventListener(MouseEvent.MOUSE_OVER, cardArray["Friend"][b].hover);
			cardArray["Friend"][b].removeEventListener(MouseEvent.MOUSE_OUT, cardArray["Friend"][b].leave);
			cardArray["Friend"][b].removeEventListener(MouseEvent.MOUSE_OVER, cardArray["Friend"][b].hoverSelected);
			cardArray["Friend"][b].removeEventListener(MouseEvent.MOUSE_OUT, cardArray["Friend"][b].leaveSelected);
			cardArray["Friend"][b].removeEventListener(MouseEvent.CLICK, cardArray["Friend"][b].characterSelected);
		}
		AIThinkSystem();
		var battleBoard: BattleBoard = new BattleBoard();
		addChildAt(battleBoard, numChildren);
		battleBoard.x = 480;
		battleBoard.y = 300;
		battleBoard.height = 400;
		battleBoard.width = 600;
	}
}

btnFinishRound.addEventListener(MouseEvent.CLICK, finishRound);
function finishRound(e:MouseEvent):void{
	btnFinishRound.visible = false;
	var resultBoard: Objects.ResultBoard = new Objects.ResultBoard();
	addChild(resultBoard);
	resultBoard.x = 530;
	resultBoard.y = 290;
}

btnGameMenu.addEventListener(MouseEvent.CLICK, openGameMenu);
function openGameMenu(e:MouseEvent):void{
	var BackgroundForm: backgroundForm = new backgroundForm();
	addChild(BackgroundForm);
	BackgroundForm.alpha = 0;
	BackgroundForm.width = 1413.55;
	BackgroundForm.height = 600;
	
	var menu: gameMenu = new gameMenu();
	menu.x = 500;
	menu.y = 300;
	addChild(menu);
}