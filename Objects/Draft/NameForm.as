package Objects.Draft {
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class NameForm extends MovieClip {
		
		private var swearList: Array = new Array();
		
		//Constructor Function
		public function NameForm() {
			//Confirm button
			btnTeamNameConfirm.lblTitle.text = "Confirm";
			btnTeamNameConfirm.addEventListener(MouseEvent.CLICK, confirmName);
			
			//Swearlist
			swearList = ["fuck", "shit", "wanker", "nigger"];
		}
		
		//Click button to confirm team name
		private function confirmName(e:MouseEvent):void{
			var main = MovieClip(root);
			var nameAllowed: Boolean = true;
			
			//Swear check
			for (var A: int = 0; A < swearList.length; A++){
				if (inputTeamName.text.search(swearList[A]) >= 0){
					nameAllowed = false;
				}
			}
			
			//Check if name is allowed
			if (inputTeamName.text != "" && nameAllowed == true){
				main.userTeamName = inputTeamName.text;
				main.TeamName.text = "Team: " + inputTeamName.text;
				main.TeamName.visible = true;
				
				//Goes to Badge Selection Form
				var badgeForm:BadgeForm = new BadgeForm();
				MovieClip(root).addChildAt(badgeForm, MovieClip(root).numChildren);
				badgeForm.gotoAndPlay(2);
				badgeForm.x = 195;
				badgeForm.y = 160;
				
				//Remove Name Form
				MovieClip(root).removeChild(this);
			}
			else if (nameAllowed == false){
				btnTeamNameConfirm.lblTitle.text = "Not allowed";
			}
			else {	//No name at all
				btnTeamNameConfirm.lblTitle.text = "Type a name";
			}
		}
	}
}