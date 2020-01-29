package Objects.TeamMenu {
	
	import flash.display.*;
	import flash.events.*;
	
	public class MenuBar2 extends MovieClip {
		
		var formAppear = MovieClip(root).formAppear;
		
		//Construction Function
		public function MenuBar2() {
			btnCampaign.addEventListener(MouseEvent.CLICK, campaignGame);
			btnSelect.addEventListener(MouseEvent.CLICK, openSelectOpponentForm);
			btnCheck.addEventListener(MouseEvent.CLICK, checkTeamForm);
			btnRestart.addEventListener(MouseEvent.CLICK, restartDraft);
		}
		
		//Campaign Button
		private function campaignGame(e:MouseEvent):void{
			MovieClip(root).gotoAndStop(5);
		}
		
		//Select Opponent Form
		private function openSelectOpponentForm(e:MouseEvent): void{
			checkDuplicateForm();
			var selectEnemyForm: SelectionForm = new SelectionForm();
			MovieClip(root).addChildAt(selectEnemyForm, MovieClip(root).numChildren);
			selectEnemyForm.x = 150;
			selectEnemyForm.y = 120;
			selectEnemyForm.loadTeamOption(0);
			selectEnemyForm.name = "FormAppear";
			formAppear = selectEnemyForm.name;
		}
		
		//Character Information Form
		import Objects.Forms.CharForm2;
		private function checkTeamForm(e:MouseEvent): void{
			checkDuplicateForm();
			var charInfoForm: Objects.Forms.CharForm2 = new Objects.Forms.CharForm2();
			MovieClip(root).addChild(charInfoForm);
			charInfoForm.x = 500;
			charInfoForm.y = 300;
			charInfoForm.height = 325;
			charInfoForm.width = 650;
			charInfoForm.gotoAndStop(1);
			charInfoForm.infoAppear(MovieClip(root).userTeam[0]);
			charInfoForm.name = "FormAppear";
			formAppear = charInfoForm.name;
		}
		
		//Restart Draft
		private function restartDraft(e:MouseEvent): void{
			MovieClip(root).gotoAndStop(2);
		}
		
		//Check for duplicate form
		private function checkDuplicateForm(){
			var formName = MovieClip(root).getChildAt(MovieClip(root).numChildren - 1).name;
			if (formName == "FormAppear" || formName == "Option"){
				MovieClip(root).removeChildAt(MovieClip(root).numChildren - 1);
			}
		}
	}	
}