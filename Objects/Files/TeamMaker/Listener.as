//Character Information
btnInfo.addEventListener(MouseEvent.CLICK, AppearInfo);
function AppearInfo(e:MouseEvent):void{
	if (Info.visible == true){
		Info.DisplayCard.Refresh();
	}
	Info.visible = true;
	Info.InfoAppear(Char);
}

//Shows summary and result of user's squad
btnMakeTeam.addEventListener(MouseEvent.CLICK, AppearResult);
function AppearResult(e:MouseEvent):void{
	CreateSummary();
	btnMakeTeam.Invisible();
	PicSummary.visible = true;
	PicSummary.play();
}

//End Draft
btnEndDraft.addEventListener(MouseEvent.CLICK, EndDraft);
function EndDraft(e:MouseEvent):void{
	gotoAndStop(4);
}

TeamBadge.addEventListener(MouseEvent.MOUSE_OVER, Hover);
TeamBadge.addEventListener(MouseEvent.MOUSE_OUT, Leave);
TeamBadge.addEventListener(MouseEvent.CLICK, AppearBadge);
function AppearBadge(e:MouseEvent):void{
	BadgeForm.play();
	BadgeForm.visible = true;
}

TeamName.addEventListener(MouseEvent.CLICK, EnterTeamName);
function EnterTeamName(e:MouseEvent):void{
	TeamName.text = ""
}