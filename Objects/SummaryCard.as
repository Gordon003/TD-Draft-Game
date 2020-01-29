package Objects {
	
	import flash.display.*;
	import flash.filters.GlowFilter;
	import flash.events.*;
	import flash.ui.Mouse;
	
	public class SummaryCard extends MovieClip {
		
		private var characterImage: Bitmap;
		private var card: Bitmap;
		private var logo: Bitmap;
		
		//PLAYER OVERVIEW
		public var player: String = "None";			//Player e.g. "DuncanTDWT"
		public var playerInfo: Array = ["None"];	//Player's Info
		
		private var playerName: String = "None";	//Player's Name e.g. "Duncan"
		private var playerRating: Array;			//Player's Rating
	
		private var selectedGlow: GlowFilter = new GlowFilter();	//When user hover on selected card
		private var cardGlow: GlowFilter = new GlowFilter();	//When user hover on the card
		
		//Construction Function
		public function SummaryCard() {
			selectedGlow.color = 0xFFFF00;
			selectedGlow.blurX = 30;
			selectedGlow.blurY = 30;
			
			cardGlow.color = 0x000000;
			cardGlow.blurX = 30;
			cardGlow.blurY = 30;
		}
		
		//Load Character
		public function loadCharacter(Name){
			if (player != "None"){
				removeChild(logo);
				removeChild(characterImage);
				removeChild(card);
			}
			else{
				removeChildAt(0);
			}
			
			player = Name;
			playerInfo = MovieClip(root).CharacterInfo[Name];
			playerRating = MovieClip(root).CharacterRating[Name];
			
			//Load Character Image
			characterImage = new Bitmap(playerInfo[1])
			addChildAt(characterImage,1);
			characterImage.x = 95;
			characterImage.y = 35;
			characterImage.height = 90;
			characterImage.width = 90;
			characterImage.smoothing = true;
			
			//Logo Image
			logo = new Bitmap(playerInfo[2]);
			addChildAt(logo,2);
			logo.x = 25;
			logo.y = 80;
			logo.height = 45;
			logo.width = 60;
			logo.smoothing = true;
	
			//Card Image
			card = new Bitmap(playerInfo[3]);
			addChildAt(card,0);
			card.height = 250;
			card.width = 200;
			card.smoothing = true;
			
			lblName.text = playerInfo[0].toUpperCase();
			lblRating.text = MovieClip(root).CharacterRating[Name][0];
	
			var D: String;
			D = playerInfo[3].toString();
	
			if (D == "[object gold1]"){
				lblName.textColor = 0x000000;
			}
			else if (D == "[object gold2]"){
				lblName.textColor = 0xFFD422;
			}
			else if (D == "[object silver2]"){
				lblName.textColor = 0xFFFFFF;
			}
			else if (D == "[object otw]"){
				lblName.textColor = 0xFFFFFF;
			}
			else if (D == "[object futties]" || D == "[object motm]"){
				lblName.textColor = 0xFFFFFF;
			}
			else if (D == "[object futmas]"){
				lblName.textColor = 0x00FF00;
			}
			else {
				lblName.textColor = 0x000000;
			}
		}
		
		import Objects.Forms.CharForm2;
		public function cardOption(e:MouseEvent):void{
			var formAppear = MovieClip(root).getChildAt(MovieClip(root).numChildren - 1).name;
			var appear = "none";
			if (formAppear == "InfoForm"){
				appear = MovieClip(root).getChildAt(MovieClip(root).numChildren - 1);
				appear = appear.view;
				MovieClip(root).removeChildAt(MovieClip(root).numChildren - 1);
			}

			var charInfo: Objects.Forms.CharInfo = new Objects.Forms.CharInfo();
			MovieClip(root).addChild(charInfo);
			charInfo.name = "InfoForm";
			charInfo.x = 500;
			charInfo.y = 300;
			charInfo.height = 325;
			charInfo.width = 650;
			if (appear == "Char Stat"){
				charInfo.gotoAndStop(2);
				charInfo.statAppear(e.currentTarget.player);
			}
			else{
				charInfo.gotoAndStop(1);
				charInfo.infoAppear(e.currentTarget.player);
			}
		}
		
		//Hover on the card (not selected)
		public function cardHover(e:MouseEvent): void{
			filters = [cardGlow];
			Mouse.cursor = "button";
		}
		
		//Leave the card (not selected)
		public function cardLeave(e:MouseEvent): void{
			filters = [];
			Mouse.cursor = "arrow";
		}
		
		//Hover on the card (selected)
		public function cardHoverSelected(e:MouseEvent):void{
			filters = [selectedGlow];
			Mouse.cursor = "button";
		}

		//Leave the card (selected)
		public function cardLeaveSelected(e:MouseEvent): void{
			Mouse.cursor = "arrow";
		}
		
	}
}