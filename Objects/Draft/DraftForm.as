package Objects.Draft {
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	
	
	public class DraftForm extends MovieClip {
		
		private var playerDraft: Array = new Array();	//Current players draft
		private var cardType: String;	//Card Selected
		private var charDrafted: String;	//Character Drafted
		private var season: String;	//Season Selected
		private var cardSeason: Array = ["TDI", "TDA", "TDWT", "TDROTI", "TDAS", "TDPI", "TDRR"];
		private var cardColour: Array = ["Gold", "Silver", "Bronze"];
		private var cardAllowed: Array;	//Card type allowed for the draft e.g. 3 golds, 2 silvers
		
		private var draftCard: Array = new Array();	//Draft Card
		private var coverArray: Array = new Array();//Cover Card
		
		//Timer to display each draft card
		private var timerDisplayCard:Timer = new Timer(400, 6);
		
		//Constructor function
		public function DraftForm() {
			timerDisplayCard.addEventListener(TimerEvent.TIMER, appearCard);
			timerDisplayCard.addEventListener(TimerEvent.TIMER_COMPLETE, timerDisplayCardComplete);
		}
		
		//Draft player
		private function startDraft(){
			var random: Number	//Used for random selection
			
			//# of Gold, Silver and Bronze cards for this draft
			do{
				random	= Math.floor(Math.random() * MovieClip(root).cardTypeNumber.length);
			} while (MovieClip(root).cardTypeNumber[random] == 0);
			
			if (random == 0){
				cardAllowed= [5,0,0];
			}
			else if (random == 1){
				cardAllowed = [3,3,0];
			}
			else if (random == 2){
				cardAllowed = [0,5,0];
			}
			else if (random == 3){
				cardAllowed = [0,2,5];
			}
			
			
			//If it's the leader then don't reduce cardTypeNumber
			if (MovieClip(root).cardSelected != MovieClip(root).DraftLeader){
				MovieClip(root).cardTypeNumber[random] -= 1;
			}
			
			//Find a character
			for (var A: int = 0; A < 5; A++){
				do{
					//Find cardType e.g. GoldTDI, BronzeTDAS
					do{
						season = cardSeason[Math.floor(Math.random() * cardSeason.length)];	//TDWT
						random = Math.floor(Math.random() * cardAllowed.length);	//Gold, Bronze...
					/*Determine if it's allowed to have this card type
						e.g. Find if Gold card is allowed, regardless of season*/
					} while (cardAllowed[random] == 0);
				
					/*Leader -> Leader + season e.g. LeaderTDPI
					Player -> Colour + Season e.g. GoldTDWT*/
					if (MovieClip(root).cardSelected == MovieClip(root).DraftLeader){
						cardType = "Leader" + season;
					}
					else{
						cardType = cardColour[random] + season;
					}
					
					//Use 'randomChar' to get a random Character
					var randomChar = Math.floor( Math.random() * MovieClip(root).Character[cardType].length);
			
					//Get name of Drafted character
					charDrafted = MovieClip(root).Character[cardType][randomChar];
			
					//Determine if that character is in the draft or team
					var duplicate = findDuplicate(MovieClip(root).CharacterInfo[charDrafted][0]);
				} while (duplicate == "true");	
		
				//Add selected character into the playerDraft Array
				playerDraft.push(charDrafted);
				
				//For leader, remove each season to get 5 leaders in different season
				if (MovieClip(root).cardSelected == MovieClip(root).DraftLeader){
					cardSeason.splice(cardSeason.indexOf(season),1);
				}
			}
		}
		
		//Find any duplicate in both team cards and draft cards
		private function findDuplicate(Name){
			var duplicate = "false";
			
			//Find if the Drafted Character is a duplicate in the player's draft
			for (var i: int = 0; i < playerDraft.length; i++){
				if (playerDraft[i].search(Name) >= 0){
					duplicate = "true";
				}
				
				if (Name == "Anne Maria"){
					if (playerDraft[i].search("AnneMaria") >= 0){
					duplicate = "true";
					}
				}
			}
				
			//Find if the Drafted Character is a duplicate in the team
			var team = MovieClip(root).teamCard;
			for (var k: int = 0; k < team.length; k++){
				if (team[k].player.search(Name) >= 0){
						duplicate = "true";
				}
				
				if (Name == "Anne Maria"){
					if (team[k].player.search("AnneMaria") >= 0){
						duplicate = "true";
					}
				}
			}
			return duplicate;
		}
		
		//Display draft card one at a time in draft
		private function appearCard(e:TimerEvent):void{
			var F = e.currentTarget.currentCount;
			if (F != 6){
				draftCard[F-1].loadCharacter(playerDraft[F-1]);	//Load Draft Character into Draft Cards
				coverArray[F-1].gotoAndPlay(2);	//Player Cover Card Animation
				}
		}
		
		//When all draft cards in draft have been displayed
		private function timerDisplayCardComplete(e:TimerEvent):void {
			for (var i: int = 0; i < 5; i++){
				//Add interaction into the draft cards
				draftCard[i].addEventListener(MouseEvent.MOUSE_OVER, hoverDraftCard);
				draftCard[i].addEventListener(MouseEvent.MOUSE_OUT, leaveDraftCard);
				//When user selects on a draft card
				draftCard[i].addEventListener(MouseEvent.CLICK, selectDraftCard);
			}
		}
		
		//User select a draft card
		private function selectDraftCard(e:MouseEvent){
			var charSelected: String;	//Selected Character
			charSelected = e.currentTarget.player;	//Selected Character's Name
			var teamCard = MovieClip(root).teamCard;	//Link to TeamCard
			
			//Load Selected Draft Character
			MovieClip(root).cardSelected.loadCharacter(charSelected);
			
			//Disappear Hide Draft button
			MovieClip(root).btnHide.Invisible();
			
			//Find if the team is finished or not
			var finished = "true";
			for (var K: int = 0; K <  teamCard.length; K++){
				teamCard[K].filters = [];	//Remove filter
				
				//Empty Player - Click to start draft
				if (teamCard[K].player == "None"){
					teamCard[K].addEventListener(MouseEvent.CLICK, teamCard[K].appearDraft);
					finished = "false";
				}
				//Player - Click to be selected
				else {
					teamCard[K].removeEventListener(MouseEvent.CLICK, teamCard[K].appearDraft);
					teamCard[K].addEventListener(MouseEvent.CLICK, teamCard[K].characterSelected);
					//Chemistry
					teamCard[K].playerChemistry = teamCard[K].calculatePlayerChemistry(K);
					MovieClip(root).chem[K].text = "Chem: " + teamCard[K].playerChemistry;
				}
				//Add Hover and Leave function
				teamCard[K].addEventListener(MouseEvent.MOUSE_OVER, teamCard[K].cardHover);
				teamCard[K].addEventListener(MouseEvent.MOUSE_OUT, teamCard[K].cardLeave);
			}
			
			//Calculate and Display Team Chemistry and Rating
			MovieClip(root).userTeamRating = calculateTeamRating();
			MovieClip(root).userTeamChemistry = calculateTeamChemistry();
			MovieClip(root).mcScore.displayTeamRatingChem();
	
			//If team is fully finished, then user click on btnMakeTeam
			if (finished == "true"){
				MovieClip(root).btnMakeTeam.Visible();
			}
	
			//Remove Draft Form
			MovieClip(root).removeChild(this);
		}
		
		//Calculate Team Chemistry
		private function calculateTeamChemistry(){
			var teamCard = MovieClip(root).teamCard;
			var total: Number = 10;	//Default Chem
	
			//Add each individual chemistry to total team chemistry
			for (var a: int = 0; a < teamCard.length; a++){
				total += teamCard[a].playerChemistry;
			}
			return total;
		}
		
		//Calculate Rating
		private function calculateTeamRating(){
			var teamCard = MovieClip(root).teamCard;
			
			var totalScore: Number = 0;	//Combined Score from all players
			var average: Number = 0;	//Average Team Rating
			var numPlayer: Number = 0;	//# of players in the team
	
			//Get individual rating
			for (var K: int = 0; K < teamCard.length; K++){
				if (teamCard[K].player != "None"){
					numPlayer += 1;
					totalScore += teamCard[K].playerOverallRating;
				}
			}
	
			//Team Rating = Total Rating / # of players
			average = Math.floor(totalScore/numPlayer);
	
			//Return the overall Team Rating Score
			return average;
		}
		
		//Hover on the draft card
		private function hoverDraftCard(e:MouseEvent):void{
			Mouse.cursor = "button";
			if (e.currentTarget.name == "DraftCard1"){
				background.gotoAndStop(2);
			}
			else if (e.currentTarget.name == "DraftCard2"){
				background.gotoAndStop(3);
			}
			else if (e.currentTarget.name == "DraftCard3"){
				background.gotoAndStop(4);
			}
			else if (e.currentTarget.name == "DraftCard4"){
				background.gotoAndStop(5);
			}
			else if (e.currentTarget.name == "DraftCard5"){
				background.gotoAndStop(6);
			}
			else{
				background.gotoAndStop(1);
			}
		}
		
		// Leave the draft card
		private function leaveDraftCard(e:MouseEvent):void{
			Mouse.cursor = "arrow";
			background.gotoAndStop(1);
		}
		
	}
}
