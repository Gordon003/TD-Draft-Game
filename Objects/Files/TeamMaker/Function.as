//Create the summary of team
function CreateSummary(){
		//Reset High Female and Male
		var HighMaleScore: Number = 0;
		var HighFemaleScore: Number = 0;
	
		for (var K: int = 0; K < (TeamCard.length); K++){
			var Gender: String = TeamCard[K].PlayerInfo[5];
			if (Gender == "Male"){
				//If the current player rating > current highest player rating
				if (TeamCard[K].PlayerRating[0] > HighMaleScore){	
					HighMaleScore = TeamCard[K].PlayerRating[0];	//Get rating
					HighMale = TeamCard[K].PlayerName;	//Get name
				}
			}
			else if (Gender == "Female"){
				if (TeamCard[K].PlayerRating[0] > HighFemaleScore){
					HighFemaleScore = TeamCard[K].PlayerRating[0];
					HighFemale = TeamCard[K].PlayerName;
				}
			}
			
			Team[K] = TeamCard[K].PlayerName
		}
		
		//Get leader
		LeaderTeam = TeamCard[0].PlayerName;
}