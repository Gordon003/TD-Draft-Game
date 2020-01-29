package Objects.Draft {
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	
	public class BadgeForm extends MovieClip {
		
		//User selected a badge
		private function badgeSelect(e:MouseEvent):void{
			MovieClip(root).userTeamBadge = e.currentTarget.badge;
			
			//Load Badge
			MovieClip(root).mcBadge.visible = true;
			MovieClip(root).mcBadge.loadBadge(e.currentTarget.badge);
			
			//New Draft Form
			import Objects.Draft.DraftForm;
			var draftForm: DraftForm = new DraftForm();
			MovieClip(root).addChildAt(draftForm, MovieClip(root).numChildren);
			draftForm.x = 190;
			draftForm.y = 185;
			draftForm.gotoAndPlay(2);
			MovieClip(root).btnHide.Visible();
	
			//Remove Badge Form
			MovieClip(root).removeChild(this);
		}
		
	}
	
}
