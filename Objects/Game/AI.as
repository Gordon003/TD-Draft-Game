function AIThinkSystem(){
	teamBattle["Enemy"] = [];
	var individualScore: Array = new Array();
	var playerArray: Array = new Array();
	var sorted: String = "True";
	var random;
	
	for (var a: int = 0; a < cardArray["Enemy"].length; a++){
		if (cardArray["Enemy"][a].used == "false"){
			cardArray["Enemy"][a].calculateScore();
			playerArray.push(cardArray["Enemy"][a]);
		}
	};

	do{
		sorted = "true";
		for (var b: int = 1; b < playerArray.length; b++){
			if (playerArray[b].score > playerArray[b-1].score){
				var temp = playerArray[b];
				playerArray[b] = playerArray[b-1];
				playerArray[b-1] = temp;
				sorted = "false";
			}
		};
	} while (sorted == "false");
	
	for (var e: int = 0; e < numPlayer; e++){
			do{
				if (playerArray.length - numPlayer <= 4){
					random = Math.floor(Math.random() * 0);
				}
				else{
					random = playerArray.length - 4;
					random = Math.floor( Math.random() * random);
				}
			} while (teamBattle["Enemy"].indexOf(playerArray[random].player) >= 0);
			teamBattle["Enemy"].push(playerArray[random].player);
			playerArray[random].selected = "true";
			playerArray.splice(random,1);
	}
}