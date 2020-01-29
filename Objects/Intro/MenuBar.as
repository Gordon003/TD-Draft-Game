package Objects.Intro {
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.ui.Mouse;
	
	public class MenuBar extends MovieClip {
		
		var formAppear = MovieClip(root).formAppear //Current Form
		
		//Constructor function
		public function MenuBar() {
			if (MovieClip(root).visited == "yes"){
				btnStart.addEventListener(MouseEvent.CLICK, goToNextFrame);	//Go to draft
				btnUpdate.addEventListener(MouseEvent.CLICK, updateForm);	//Update Form
				btnOption.addEventListener(MouseEvent.CLICK, optionForm);	//Option Form
				btnCredit.addEventListener(MouseEvent.CLICK, creditForm);	//Credit Form
			}
		}
		
		//Draft Button - Go to Draft Screen (Frame 3)
		public function goToNextFrame(e:MouseEvent):void{
			removeDuplicateForm();
			MovieClip(root).gotoAndStop(3);
		}
		
		//Credit Button - Credit Form
		public function creditForm(e:MouseEvent): void{
			removeDuplicateForm();
			var credits:CreditForm = new CreditForm();
			MovieClip(root).addChild(credits);
			credits.x = 210;
			credits.y = 150;
			credits.name = "FormAppear";
			formAppear = credits.name;
		}
		
		//Option Button - Option Form
		public function optionForm(e:MouseEvent): void{
			removeDuplicateForm();
			var options:OptionForm = new OptionForm();
			MovieClip(root).addChild(options);
			options.x = 500;
			options.y = 275;
			options.name = "FormAppear";
			formAppear = options.name;
		}
		
		//Update Form
		public function updateForm(e:MouseEvent): void{
			removeDuplicateForm();
			var updates:UpdateForm = new UpdateForm();
			MovieClip(root).addChild(updates);
			updates.x = 210;
			updates.y = 150;
			updates.name = "FormAppear";
			formAppear = updates.name;
		}
		
		private function removeDuplicateForm(){
			var formName = MovieClip(root).getChildAt(MovieClip(root).numChildren - 1).name;
			var form = (MovieClip(root).getChildAt(MovieClip(root).numChildren - 1));
			
			if (form == "[object CreditForm]"){
				form.lblText.stop();
			}
			
			if (formName == "FormAppear"){
				MovieClip(root).removeChildAt(MovieClip(root).numChildren - 1);
			}
		}
		
	}	
}