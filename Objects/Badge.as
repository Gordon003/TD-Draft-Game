package Objects {
	
	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	
	public class Badge extends MovieClip {
		private var badgeGlow: GlowFilter = new GlowFilter();
		
		//Constructor
		public function Badge() {
			badgeGlow.color = 0x000000;
			badgeGlow.blurX = 30;
			badgeGlow.blurY = 30;
		}
		
		//Hover on the badge
		public function hoverBadge(e:MouseEvent): void{
			e.currentTarget.filters = [badgeGlow];
			Mouse.cursor = "button";
		}

		//Leave the badge
		public function leaveBadge(e:MouseEvent): void{
			e.currentTarget.filters = [];
			Mouse.cursor = "arrow";
		}
		
	}
	
}
