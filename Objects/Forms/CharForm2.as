package Objects.Forms{
	
	import flash.display.*;
	import flash.events.*;
	
	
	public class CharForm2 extends MovieClip {
		
		private var player: String;
		private var position: Number = 0;
		private var view: String = "Char Info";
		
		//Construction Function
		public function CharForm2() {
			btnInfo.lblTitle.text = "Main Info";
			btnInfo.addEventListener(MouseEvent.CLICK, appearCharInfo);
			btnStat.lblTitle.text = "Stats";
			btnStat.addEventListener(MouseEvent.CLICK, appearCharStat);
			btnLeft.addEventListener(MouseEvent.CLICK, moveLeft);
			btnRight.addEventListener(MouseEvent.CLICK, moveRight);
		}
		
		//User click to see previous character
		private function moveLeft(e: MouseEvent){
			position -= 1
			if (position == -1){
				position = 8;
			}
			
			if (view == "Char Info"){
				gotoAndStop(1);
				infoAppear(MovieClip(root).userTeam[position]);
			}
			else{
				gotoAndStop(2);
				statAppear(MovieClip(root).userTeam[position])
			}
		}
		
		//User click to see next character
		private function moveRight(e: MouseEvent){
			position += 1
			if (position == 9){
				position = 0;
			}
			
			if (view == "Char Info"){
				gotoAndStop(1);
				infoAppear(MovieClip(root).userTeam[position]);
			}
			else{
				gotoAndStop(2);
				statAppear(MovieClip(root).userTeam[position])
			}
		}
		
		//User click to look at character's info
		private function appearCharInfo(e:MouseEvent){
			gotoAndStop(1);
			infoAppear(MovieClip(root).userTeam[position]);
		}
		
		//Load Character's Info
		public function infoAppear(char){
			var	charInfo: Array = MovieClip(root).CharacterInfo[char];
			var charName: String = charInfo[0];
			var abilityText: String = charInfo[6];
			var friend: Array = MovieClip(root).CharacterFriend[charName];	
			var enemy: Array = MovieClip(root).CharacterEnemy[charName];		
			var nickname: Array = MovieClip(root).Nickname;
			player = char;
	
			//Display player's name in upper case
			lblHeadName.text = charName.toUpperCase();
	
			//Display player's name
			lblName.text = charName.toString();
	
			//Display Nickname
			lblKnown.text = nickname[charName][0];
			
			//Display Ability
			lblAbilityHead.text = abilityText.toString();
			//lblAbilityText.text = MovieClip(root).AbilityList[abilityText][1];
	
			//Display DisplayCard with selected character
			DisplayCard.loadCharacter(char);
	
			//Friend and Enemy Text
			lblFriend.text = "";
			lblEnemy.text = "";
			
			var asd: Number = friend.length
	
			//Friend
			for (var i: int = 0; i < asd; i++){
				//If it's the last friend, then it doesn't need the comma
				if (i == asd - 1){
					lblFriend.appendText(friend[i]);
				}
				else {
					lblFriend.appendText(friend[i] + ", ");
				}
			}
	
			//Enemy
			asd = enemy.length
			for (var j: int = 0; j < asd; j++){
				//If it's the last enemy, then it doesn't need the comma
				if (j == (asd - 1)){
					lblEnemy.appendText(enemy[j]);
				}
				else {
					lblEnemy.appendText(enemy[j] + ", ");
				}
			}
		}
		
		//User click to look at character's stat
		private function appearCharStat(e:MouseEvent){
			gotoAndStop(2);
			statAppear(MovieClip(root).userTeam[position]);
		}
		
		//Load Character's Stat
		public function statAppear(char){
			view = "Char Stat";
			
			var charRating: Array = MovieClip(root).CharacterRating[char];	
			
			//Display player's name in upper case
			lblHeadName.text = MovieClip(root).CharacterInfo[char][0].toUpperCase();
			
			DisplayCard.loadCharacter(char);
			
			var stats: Array = new Array();
			stats["Label"] = [lblAth, lblInt, lblDet, lblLoy, lblPop, lblStr];
			stats["Name"] = ["Athletic", "Intelligence", "Determination", "Loyalty", "Popularity", "Strength"];
			stats["Bar"] = [picAthBar, picIntBar, picDetBar, picLoyBar, picPopBar, picStrBar]
			
			for (var i: int = 0; i < stats["Label"].length; i++){
				var rating = charRating[i + 1];
				stats["Label"][i].text = stats["Name"][i] + " : " + rating;
				stats["Bar"][i].scaleX = rating/100;
				//Change bar colour based on rating
				if (rating < 35){
					stats["Bar"][i].gotoAndStop(1);
				}
				else if (rating > 70){
					stats["Bar"][i].gotoAndStop(3);
				}
				else {
					stats["Bar"][i].gotoAndStop(2);
				}
			}
			
		}
	}
}