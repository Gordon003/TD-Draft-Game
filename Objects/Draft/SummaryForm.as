package Objects.Draft {
	
	import flash.display.*;
	import flash.filters.*;
	
	
	public class SummaryForm extends MovieClip {
		
		private var highMale: String;	//Highest Rated Male
		private var highMaleScore: Number = 0;

		private var highFemale: String;	//Highest Rated Female
		private var highFemaleScore: Number = 0;

		private var leader;	//Leader
		
		//Create Team Summary
		public function createSummary(){
			var main = MovieClip(root).userTeam;
			trace(MovieClip(root).userTeam);
			
			for (var K: int = 0; K < (main.length); K++){
				var player = main[K];
				var playerOverallRating = MovieClip(root).CharacterRating[player][0];
				var Gender: String = MovieClip(root).CharacterInfo[player][5];
				
				//If that character is male
				if (Gender == "Male"){
				//If the current player rating > current highest player rating
					if (playerOverallRating > highMaleScore){
						//Get the player's rating
						highMaleScore = playerOverallRating;
						//Get the player's name
						highMale = player;
					}
				}
				//If that character is female
				else if (Gender == "Female"){
					if (playerOverallRating > highFemaleScore){
						highFemaleScore = playerOverallRating;
						highFemale = player;
					}
				}
				
			}
		}
		
	
	}
	
}
