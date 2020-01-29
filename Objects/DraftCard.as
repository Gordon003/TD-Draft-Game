package  Objects{
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.text.TextFormat;
	import flash.ui.Mouse;
	import Objects.Draft.DraftForm;
	
	public class DraftCard extends MovieClip{
		
		//IMAGE
		private var characterImage: Bitmap = null;	//Character Image
		private var card: Bitmap = null;			//Card Image
		private var logo: Bitmap = null;			//Logo Image
		
		//PLAYER OVERVIEW
		public var player: String = "None";			//Player e.g. "DuncanTDWT"
		public var playerInfo: Array = ["None"];	//Player's Info
		public var playerOverallRating: Number = 0;	//Player's Overall Rating
		public var playerChemistry: Number = 0;		//Player's Individual Chemistry
		
		private var playerName: String = "None";	//Player's Name e.g. "Duncan"
		private var playerRating: Array;			//Player's Rating
	
		private var selectedGlow: GlowFilter = new GlowFilter();	//When user hover on selected card
		private var cardGlow: GlowFilter = new GlowFilter();	//When user hover on the card
		
		//Constructor function
		public function DraftCard() {
			selectedGlow.color = 0xFFFF00;
			selectedGlow.blurX = 30;
			selectedGlow.blurY = 30;
			
			cardGlow.color = 0x000000;
			cardGlow.blurX = 30;
			cardGlow.blurY = 30;
		}
		
		//Display Selected Draft Card
		public function loadCharacter(Name){
			appearCardStat();	//Appear all stats
			
			//If there is already another character, then remove the bitmap
			if (player != "None"){
				removeChild(logo);
				removeChild(characterImage);
				removeChild(card);
			}
			else{
				removeChildAt(0);
			}
			
			player = Name;	//Overall player e.g. DuncanTDWT
			playerInfo = MovieClip(root).CharacterInfo[Name];	//Player's Info
			playerName = playerInfo[0];	//Player's Name e.g. Duncan
			
			//Load Character Image
			characterImage = new Bitmap(playerInfo[1])
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
			
			//Get player's overall rating
			playerOverallRating = MovieClip(root).CharacterRating[Name][0];
			playerRating = MovieClip(root).CharacterRating[Name];
	
			/*DISPLAY STATS
			Stat on the card for display
				Used to apply effect for different cards*/
			var Stat:Array = new Array;
			Stat[1] = [lblRating, lblAth, lblInt, lblDet, lblLoy, lblPop, lblStr];
			Stat[2] = [lblName, ATH, INTE, DET, LOY, POP, STR];
			
			//Display character's name in upper case
			lblName.text = playerName.toUpperCase();
			
			//Type of card - used to apply colour on the text field
			var cardType: String;
			cardType = playerInfo[3].toString();
	
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
		
		//Click to open option
		public function selectCardOption(e:MouseEvent){
			trace("Here");
			MovieClip(root).btnSelectChar4.Visible();
			MovieClip(root).cardSelected = this;
		}
		
		//Click to start draft
		public function appearDraft(e:MouseEvent){
			var main = MovieClip(root).teamCard;
			
			MovieClip(root).cardSelected = this;
			MovieClip(root).removeDuplicateForm();
			MovieClip(root).firstCharSelected = "";
			MovieClip(root).btnInfo.Invisible();	//Disappear Info button
			MovieClip(root).btnSwap.Invisible();	//Disappear Swap button
			Mouse.cursor = "arrow";
	
			//Remove team card's event listener
			for (var K: int = 0; K <  main.length; K++){
				main[K].removeEventListener(MouseEvent.CLICK, main[K].appearDraft);
				main[K].removeEventListener(MouseEvent.MOUSE_OVER, main[K].cardHover);
				main[K].removeEventListener(MouseEvent.MOUSE_OUT, main[K].cardLeave);
				main[K].removeEventListener(MouseEvent.MOUSE_OVER, main[K].cardHoverSelected);
				main[K].removeEventListener(MouseEvent.MOUSE_OUT, main[K].cardLeaveSelected);
				main[K].removeEventListener(MouseEvent.CLICK, main[K].characterSelected);
				main[K].filters = [];
			}
			
			filters = [selectedGlow];	//Highlight which draft card is selected
			
			//Display Draft
			var draftForm: Objects.Draft.DraftForm = new Objects.Draft.DraftForm();
			MovieClip(root).addChildAt(draftForm, MovieClip(root).numChildren);
			draftForm.x = 190;
			draftForm.y = 185;
			draftForm.gotoAndPlay(2);
			MovieClip(root).btnHide.Visible();
		}
		
		//Calculate player's Chemistry
		public function calculatePlayerChemistry(num){
			var chemistry = 5;	//Default Chemistry	
			
			var friendData:Array = MovieClip(root).CharacterFriend[playerName];	//Friend Database
			var enemyData: Array = MovieClip(root).CharacterEnemy[playerName];	//Enemy Database
			var teamCard: Array = new Array();	//Each Team Member
			teamCard = [MovieClip(root).DraftLeader, MovieClip(root).DraftCard1, MovieClip(root).DraftCard2, MovieClip(root).DraftCard3, MovieClip(root).DraftCard4, MovieClip(root).DraftCard5, MovieClip(root).DraftCard6, MovieClip(root).DraftCard7, MovieClip(root).DraftCard8];
			teamCard.splice(num,1);	//Remove the selected card position # from the Num Array
			
			//FIND CHEMISTRY
			for (var J: int = 0; J < teamCard.length; J++){
				var teamMate: String = teamCard[J].playerName;
				//Ensure that the teammate is a member
				if (teamMate != "None"){
					/*SEASON
						If both are from the same season, the player get a +1 chemistry boost*/
					if (playerInfo[2] == teamCard[J].playerInfo[2]){
						chemistry += 1;
					}
			
					/*FRIEND
						If both are friends, the player get a +1 chemistry boost*/
					for (var a: int = 0; a < friendData.length; a++){
						if (friendData[a].search(teamMate) >= 0){
							if (friendData[a].search("x2") >= 0){
								chemistry += 2;
							}
							else if (friendData[a].search("x3") >= 0){
								chemistry += 3;
							}
							else{
								chemistry += 1;
							}
						}
					}
			
					/*ENEMY
						If both are enemies, the player get a -1 chemistry boost*/
					for (var b: int = 0; b < enemyData.length; b++){
						if (enemyData[b].search(teamMate) >= 0){
							if (enemyData[b].search("x2") >= 0){
								chemistry -= 2;
							}
							else{
								chemistry -= 1;
							}
						}
					}
				}
			}
	
			//Ensure Chemistry is between 1-10
			if (chemistry > 10){
				chemistry = 10;
			}
			else if (chemistry < 1){
				chemistry = 1;
			}	
			
			return chemistry;
		}
		
		//Select Character
		public function characterSelected(e:MouseEvent):void{
			var mainChar: String = MovieClip(root).firstCharSelected;	//The previous selected Character
			var main = MovieClip(root).teamCard;
			
			//Get the current selected Character
			MovieClip(root).firstCharSelected = player;
	
			//Disable team card
			for (var K: int = 0; K <  main.length; K++){
				main[K].addEventListener(MouseEvent.MOUSE_OVER, main[K].cardHover);
				main[K].addEventListener(MouseEvent.MOUSE_OUT, main[K].cardLeave);
				main[K].addEventListener(MouseEvent.MOUSE_OUT, main[K].cardLeave);
				main[K].filters = [];
			}		
	
			//If it is the same player, then it is deselected
			if (mainChar == MovieClip(root).firstCharSelected){
				filters = [];
				Mouse.cursor = "button";
				MovieClip(root).firstCharSelected = "";
				MovieClip(root).btnInfo.Invisible();
				MovieClip(root).btnSwap.Invisible();
			}
			else {
				//Add selected hover function for the draft card
				removeEventListener(MouseEvent.MOUSE_OVER, cardHover);
				removeEventListener(MouseEvent.MOUSE_OUT, cardLeave);
				addEventListener(MouseEvent.MOUSE_OVER, cardHoverSelected);
				addEventListener(MouseEvent.MOUSE_OUT, cardLeaveSelected);
				dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER));
				
				MovieClip(root).btnInfo.Visible();	//Appear Information button
				
				//Swap Button
				if (MovieClip(root).firstCharSelected != main[0].player){
					//If it's the leader, it can't be swapped and don't show the swap button
					MovieClip(root).btnSwap.Visible();
				}
				else {
					MovieClip(root).btnSwap.Invisible();
				}
			}
		}
		
		//Make all stats appear
		public function appearCardStat(){
			var Text1: Array = new Array();
			Text1 = [lblRating, lblName, ATH, lblAth, INTE, lblInt, DET, lblDet, LOY, lblLoy, POP, lblPop, STR, lblStr];
			for (var i: int = 0; i < Text1.length; i++){
				Text1[i].visible = true;
			}
		}
		
		//Make all stats disappear
		public function clearCardStat(){
			var Text: Array = new Array();
			Text = [lblRating, lblName, ATH, lblAth, INTE, lblInt, DET, lblDet, LOY, lblLoy, POP, lblPop, STR, lblStr];
			for (var i: int = 0; i < Text.length; i++){
				Text[i].visible = false;
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
			if (MovieClip(root).firstCharSelected == player && MovieClip(root).TeamName.text == "Who do u want to swap with?"){
				MovieClip(root).TeamName.text = "Click to cancel swap";
			}
		}

		//Leave the card (selected)
		public function cardLeaveSelected(e:MouseEvent): void{
			Mouse.cursor = "arrow";
			if (MovieClip(root).TeamName.text == "Click to cancel swap"){
				MovieClip(root).TeamName.text = "Who do u want to swap with?";
			}
		}
	
	}
}
