package  Objects{
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	
	import flash.geom.ColorTransform;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import flash.text.TextColorType;
	
	public class GameCard extends MovieClip{
		
		//Character Image
		private var characterImage: Bitmap;
		//Card Image
		private var card: Bitmap;
		//Logo Image
		private var logo: Bitmap;

		//PLAYER OVERVIEW
		//Player
		public var player: String = "None";
		//Player's Name
		private var playerName: String = "None";
		//Player's Info
		public var playerInfo: Array = ["None"];
		//Player's Rating
		public var playerRating: Array;
		//Player's Individual Chemistry
		public var playerChemistry: Number = 0;
	
		//Overall Rating
		public var playerOverallRating: Number = 0;
		//Atheltic Rating
		private var playerAthleticRating: Number = 0;
		//Intelligence Rating
		private var playerIntelligenceRating:Number = 0;
		//Determination Rating
		private var playerDeterminationRating: Number = 0;
		//Loyalty Rating
		private var playerLoyaltyRating: Number = 0;
		//Popularity Rating
		private var playerPopularityRating: Number = 0;
		//Strength Rating
		private var playerStrengthRating: Number = 0;
	
		//Glow when user selected the card
		private var selectedGlow: GlowFilter = new GlowFilter();
		//Glow when user hover on the card
		private var cardGlow: GlowFilter = new GlowFilter();
		//Original text colour
		private var originalTextColour: TextColorType = new TextColorType();
		
		public var used: String = "false";
		
		public var selected: String = "false";
		
		public var score: Number = 0;
		
		private var Stat:Array = new Array;
		
		//Constructor function
		public function GameCard() {
			selectedGlow.color = 0xFFFF00;
			selectedGlow.blurX = 30;
			selectedGlow.blurY = 30;
			
			cardGlow.color = 0x000000;
			cardGlow.blurX = 30;
			cardGlow.blurY = 30;
			
			Stat[1] = [lblRating, lblAth, lblInt, lblDet, lblLoy, lblPop, lblStr];
			Stat[2] = [lblName, ATH, INTE, DET, LOY, POP, STR];
		}
		
		//Get the selected character and display it
		public function loadCharacter(Name){
			//If there is already another , then remove the bitmap of that character
			if (player != "None"){
				removeChild(logo);
				removeChild(characterImage);
				removeChild(card);
			}
			else{
				removeChildAt(0);
			}
			
			//Overall player e.g. DuncanTDWT
			player = Name;
			//Player's Info
			playerInfo = MovieClip(root).CharacterInfo[Name];
			//Player's name e.g. Duncan
			playerName = playerInfo[0];
			
			//Load Character Image
			characterImage = new Bitmap(playerInfo[1]);
			addChildAt(characterImage,1);
			characterImage.x = 84.95;
			characterImage.y = 40;
			characterImage.smoothing = true;
	
			//Load Logo Image
			logo = new Bitmap(playerInfo[2]);
			addChildAt(logo,2);
			logo.x = 32;
			logo.y = 65;
			logo.height = 40;
			logo.width = 55;
			logo.smoothing = true;
	
			//Load Card Image
			card = new Bitmap(playerInfo[3]);
			addChildAt(card,0);
			card.height = 300;
			card.width = 200;
			card.smoothing = true;
			
			//Load Stats
			playerOverallRating = MovieClip(root).CharacterRating[Name][0];
			playerAthleticRating = MovieClip(root).CharacterRating[Name][1];
			playerIntelligenceRating = MovieClip(root).CharacterRating[Name][2];
			playerDeterminationRating = MovieClip(root).CharacterRating[Name][3];
			playerLoyaltyRating = MovieClip(root).CharacterRating[Name][4];
			playerPopularityRating = MovieClip(root).CharacterRating[Name][5];
			playerStrengthRating = MovieClip(root).CharacterRating[Name][6];
			
	
			/*DISPLAY STATS
			Stat on the card for display
				Used to apply effect for different cards*/
			
			//Display character's name in upper case
			lblName.text = playerName.toUpperCase();
			
			var cardType: String;
			cardType = playerInfo[3].toString();
	
			//Apply colour on the text field
			for (var i: int = 0; i < Stat[1].length; i++){
				//Show respective statistic
				Stat[1][i].text = MovieClip(root).CharacterRating[Name][i];
				Stat[1][i].visible = true;
				
				//Apply text colour
				lblRating.textColor = 0x000000;
				if (cardType == "[object gold1]"){
					Stat[1][i].textColor = 0x000000;
					Stat[2][i].textColor = 0x000000;
				}
				else if (cardType == "[object gold2]"){
					Stat[1][i].textColor = 0xFFD422;
					Stat[2][i].textColor = 0xFFD422;
				}
				else if (cardType == "[object silver2]"){
					Stat[1][i].textColor = 0xFFFFFF;
					Stat[2][i].textColor = 0xFFFFFF;
				}
				else if (cardType == "[object otw]"){
					Stat[1][i].textColor = 0xFFFFFF;
					Stat[2][i].textColor = 0xFFFFFF;
					lblRating.textColor = 0xFFFFFF;

				}
				else if (cardType == "[object futties]" || cardType == "[object motm]"){
					Stat[1][i].textColor = 0xFFFFFF;
					Stat[2][i].textColor = 0xFFFFFF;
				}
				else if (cardType == "[object futmas]"){
					Stat[1][i].textColor = 0x00FF00;
					Stat[2][i].textColor = 0x00FF00;
					lblName.textColor = 0x000000;
				}
				else {
					Stat[1][i].textColor = 0x000000;
					Stat[2][i].textColor = 0x000000;
				}
			}
		}
		
		//Select Character
		public function characterSelected(e:MouseEvent){
			if (selected == "false"){
				selected = "true";
				y -= 20;
				filters = [selectedGlow];
				
				removeEventListener(MouseEvent.MOUSE_OVER, hover);
				removeEventListener(MouseEvent.MOUSE_OUT, leave);
				addEventListener(MouseEvent.MOUSE_OVER, hoverSelected);
				addEventListener(MouseEvent.MOUSE_OUT, leaveSelected);
			}
			else{
				selected = "false"
				y += 20;
				filters = [];
				
				addEventListener(MouseEvent.MOUSE_OVER, hover);
				addEventListener(MouseEvent.MOUSE_OUT, leave);
				removeEventListener(MouseEvent.MOUSE_OVER, hoverSelected);
				removeEventListener(MouseEvent.MOUSE_OUT, leaveSelected);
			}
		}
		
		//Calculate player's score in challenges
		public function calculateScore(){
			var main = MovieClip(root);
			var attribute;
			score = 0;
			for (var e: int = 0; e < main.ChallengeAttributes[main.challenge].length; e++){
				attribute = main.ChallengeAttributes[main.challenge][e];
				
				if (attribute.search("Athletic") >= 0){
					if (attribute.search("x2") >= 0){
						score += playerAthleticRating * 2;
						
					}
					else if (attribute.search("x3") >= 0){
						score += playerAthleticRating * 3;
					}
					else{
						score += playerAthleticRating;
					}
				}
				
				if (attribute.search("Intelligence") >= 0){
					if (attribute.search("x2") >= 0){
						score += playerIntelligenceRating * 2;
					}
					else if (attribute.search("x3") >= 0){
						score += playerIntelligenceRating * 3;
					}
					else{
						score += playerIntelligenceRating;
					}
				}
				
				if (attribute.search("Determination") >= 0){
					if (attribute.search("x2") >= 0){
						score += playerDeterminationRating * 2;
					}
					else if (attribute.search("x3") >= 0){
						score += playerDeterminationRating * 3;
					}
					else{
						score += playerDeterminationRating;
					}
				}
				
				if (attribute.search("Loyalty") >= 0){
					if (attribute.search("x2") >= 0){
						score += playerLoyaltyRating * 2;
					}
					else if (attribute.search("x3") >= 0){
						score += playerLoyaltyRating * 3;
					}
					else{
						score += playerLoyaltyRating;
					}
				}
				
				if (attribute.search("Popularity") >= 0){
					if (attribute.search("x2") >= 0){
						score += playerPopularityRating * 2;
						
					}
					else if (attribute.search("x3") >= 0){
						score += playerPopularityRating * 3;
					}
					else{
						score += playerPopularityRating;
					}
				}
				
				if (attribute.search("Strength") >= 0){
					if (attribute.search("x2") >= 0){
						score += playerStrengthRating * 2;
					}
					else if (attribute.search("x3") >= 0){
						score += playerStrengthRating * 3;
					}
					else {
						score += playerStrengthRating;
					}
				}
			}
		}
		
		//Cross out the card
		public function crossOut(){
			var Cross: cross = new cross();
			addChild(Cross);
			Cross.x = 100;
			Cross.y = 150;
		}
		
		//Remove cross
		public function removeCrossOut(){
			removeChildAt(numChildren - 1);
		}
		
		//Glow specific stats
		public function glowStat(){
			var attributesRequired = MovieClip(root).ChallengeAttributes[MovieClip(root).challenge];
			
			for (var i: int = 0; i < attributesRequired.length; i++){
				if (attributesRequired[i].search("Athletic") >= 0){
					Stat[1][1].textColor = 0xFF0000;
					Stat[2][1].textColor = 0xFF0000;
				}
				if (attributesRequired[i].search("Intelligence") >= 0){
					Stat[1][2].textColor = 0xFF0000;
					Stat[2][2].textColor = 0xFF0000;
				}
				if (attributesRequired[i].search("Determination") >= 0){
					Stat[1][3].textColor = 0xFF0000;
					Stat[2][3].textColor = 0xFF0000;
				}
				if (attributesRequired[i].search("Loyalty") >= 0){
					Stat[1][4].textColor = 0xFF0000;
					Stat[2][4].textColor = 0xFF0000;
				}
				if (attributesRequired[i].search("Popularity") >= 0){
					Stat[1][5].textColor = 0xFF0000;
					Stat[2][5].textColor = 0xFF0000;
				}
				if (attributesRequired[i].search("Strength") >= 0){
					Stat[1][6].textColor = 0xFF0000;
					Stat[2][6].textColor = 0xFF0000;
				}
			}
		}
		
		//Remove text oolour
		public function removeGlowStat(){
			var cardType: String;
			cardType = playerInfo[3].toString();
			
			//Apply colour on the text field
			for (var i: int = 1; i < Stat[1].length; i++){
				if (cardType == "[object gold1]"){
					Stat[1][i].textColor = 0x000000;
					Stat[2][i].textColor = 0x000000;
				}
				else if (cardType == "[object gold2]"){
					Stat[1][i].textColor = 0xFFD422;
					Stat[2][i].textColor = 0xFFD422;
				}
				else if (cardType == "[object silver2]"){
					Stat[1][i].textColor = 0xFFFFFF;
					Stat[2][i].textColor = 0xFFFFFF;
				}
				else if (cardType == "[object otw]"){
					Stat[1][i].textColor = 0xFFFFFF;
					Stat[2][i].textColor = 0xFFFFFF;
				}
				else if (cardType == "[object futties]" || cardType == "[object motm]"){
					Stat[1][i].textColor = 0xFFFFFF;
					Stat[2][i].textColor = 0xFFFFFF;
				}
				else if (cardType == "[object futmas]"){
					Stat[1][i].textColor = 0x00FF00;
					Stat[2][i].textColor = 0x00FF00;
				}
				else {
					Stat[1][i].textColor = 0x000000;
					Stat[2][i].textColor = 0x000000;
				}
			}
		}
		
		//Hover on the card (not selected)
		public function hover(e:MouseEvent): void{
			filters = [cardGlow];
			Mouse.cursor = "button";
		}
		
		//Leave the card (not selected)
		public function leave(e:MouseEvent): void{
			e.currentTarget.filters = [];
			Mouse.cursor = "arrow";
		}
		
		//Hover on the card (selected)
		public function hoverSelected(e:MouseEvent):void{
			filters = [selectedGlow];
			Mouse.cursor = "button";
		}

		//Leave the card (selected)
		public function leaveSelected(e:MouseEvent): void{
			Mouse.cursor = "arrow";
		}
	}
	
}
