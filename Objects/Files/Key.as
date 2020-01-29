/*
//When user press a key
function ASD(event:KeyboardEvent):void {
	//Press Enter
    if (event.keyCode == Keyboard.ENTER){
		if(NameBack.visible == true && NameBack.TeamName.text != ""){
			event.currentTarget.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			//ConfirmName
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,ASD);
		}
	}
	
}
*/