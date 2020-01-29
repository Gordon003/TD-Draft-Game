//Calculate Rating
function CalculateRating(){
	
	var TotalScore: Number = 0;
	var Average: Number = 0;
	var NumPlayer: Number = 0;
	
	//Get individual rating
	for (var K: int = 0; K < TeamCard.length; K++){
		if (TeamCard[K].PlayerName != "None"){
			NumPlayer += 1;
			//Add the character rating to Total Score
			TotalScore += TeamCard[K].PlayerRating[0];
		}
	}
	
	//Divide Total Score by Number of Player to get average rating
	Average = Math.floor(TotalScore/NumPlayer)
	//Store result in array TeamInfo
	TeamInfo[1] = Average;
}

//Calculate Chemistry
function CalculateChemistry(Digit){
	//Digit Indicate position of card
		//e.g. Leader is Card Number 0;
	
	var Num: Array = [0,1,2,3,4,5,6,7,8];
	
	var Chemistry: Number = 5;	//Default Chemistry
	var Player: String = TeamCard[Digit].PlayerName;	//Player Database
	
	var CharName: String = TeamCard[Digit].PlayerInfo[0];	//Player Actual Name
	var Friend:Array = CharacterFriend[CharName];
	var Enemy: Array = CharacterEnemy[CharName];
	
	Num.splice(Digit,1);
	
	for (var J: int = 0; J < Num.length; J++){
		var a = Num[J];
		//Get individual teammate
		var TeamMate: String = TeamCard[a].PlayerName;
		
		if (TeamMate != "None"){
			if (Player.search("Legend") >= 0){	//Legend
				Chemistry += 1;
			}
			//If both are from same season, they both get chemistry boost
			if (TeamCard[Digit].PlayerInfo[2] == TeamCard[a].PlayerInfo[2]){
				Chemistry += 1;
			}
			
			//Friend List
			for (var b: int = 0; b < Friend.length; b++){
				if (TeamMate.search(Friend[b]) >= 0){
					Chemistry += 1;
				}
			}
			
			//Enemy List
			for (var c: int = 0; c < Enemy.length; c++){
				if (TeamMate.search(Enemy[c]) >= 0){
					Chemistry -= 1;
				}
			}
			
			//Legend
			if (TeamMate.search("Legend") >= 0){
				Chemistry += 1;
			}
		}
		
	}
	
	if (Chemistry > 10){	//If chemistry is already higher than 10,
		Chemistry = 10;			//It return back to 10
	}
	else if (Chemistry < 1){	//If chemistry is 0 or below, it returns back to 1
		Chemistry = 1;
	}
	TeamCard[Digit].PlayerChemistry = Chemistry;
}

//Get total chemistry
function TotalChemistry(){
	//Default Chemistry - to able user to get 100 (Full Chem);
	var Total: Number = 10;
	//Add each individual chemistry to total team chemistry
	for (var a: int = 0; a < TeamCard.length; a++){
		Total += TeamCard[a].PlayerChemistry;
	}
	TeamInfo[2] = Total;
}