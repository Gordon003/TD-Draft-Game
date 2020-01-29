package Objects.TeamMenu {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	
	public class SelectionForm extends MovieClip {
		
		private var pageNum: Number = 0;
		private var teamBadgeArray: Array = [TeamBadge1, TeamBadge2, TeamBadge3, TeamBadge4];
		
		// Construction Function
		public function SelectionForm() {
			btnPlay1.addEventListener(MouseEvent.CLICK, showOpponent);
			btnPlay2.addEventListener(MouseEvent.CLICK, showOpponent);
			btnPlay3.addEventListener(MouseEvent.CLICK, showOpponent);
			btnPlay4.addEventListener(MouseEvent.CLICK, showOpponent);
			
			btnPrevious.addEventListener(MouseEvent.CLICK, previousOpponent);
			btnPrevious.visible = false;
			btnNext.addEventListener(MouseEvent.CLICK, nextOpponent);
		}
		
		//Load Previous 4 Opponents
		private function previousOpponent(e:MouseEvent){
			pageNum -= 4;
			btnNext.visible = true;
			if (pageNum == 0){
				e.currentTarget.visible = false;
			}
			else{
				e.currentTarget.visible = true;
			}
			loadTeamOption(pageNum);
		}
		
		//Load Next 4 Opponents
		private function nextOpponent(e:MouseEvent){
			pageNum += 4;
			btnPrevious.visible = true;
			if (pageNum >= MovieClip(root).otherUserTeamInfo.length - 4){
				e.currentTarget.visible = false;
			}
			else{
				e.currentTarget.visible = true;
			}
			loadTeamOption(pageNum);
		}
		
		//Load Opponent Option
		public function loadTeamOption(Num){
			var otherTeam = MovieClip(root).otherUserTeam;
			var otherTeamInfo = MovieClip(root).otherUserTeamInfo;
			var characterInfo = MovieClip(root).CharacterInfo;
			var teamLength = otherTeamInfo.length;
			
			var teamNameText: Array = [lblTeamName1, lblTeamName2, lblTeamName3, lblTeamName4];
			var userNameText: Array = [lblUserName1, lblUserName2, lblUserName3, lblUserName4];
			var teamBadgeList: Array = [TeamBadge1, TeamBadge2, TeamBadge3, TeamBadge4];
			var btnPlay: Array =[btnPlay1, btnPlay2, btnPlay3, btnPlay4];
			
			for (var A: int = 0; A < 4; A++){
				teamNameText[A].text = "";
				userNameText[A].text = "";
				teamBadgeList[A].visible = false;
				btnPlay[A].visible = false;
				
				var currentPage = A + Num;
				if (currentPage < teamLength){
					teamNameText[A].text = "Team: " + otherTeamInfo[currentPage][1];
					userNameText[A].text = "User: " + otherTeamInfo[currentPage][0];
					teamBadgeList[A].visible = true;
					teamBadgeList[A].loadBadge(otherTeamInfo[currentPage][2]);
					btnPlay[A].visible = true;
				}
			}
		}
		
		//User click on a selected opponent
		private function showOpponent(e:MouseEvent):void{
			var btnPlay: Array =[btnPlay1, btnPlay2, btnPlay3, btnPlay4];
	
			var num = btnPlay.indexOf(e.currentTarget) + pageNum;
			var main = MovieClip(root);
	
			main.enemy = main.otherUserTeamInfo[num][0];
			main.enemyTeam = main.otherUserTeam[num];
			main.enemyTeamName = main.otherUserTeamInfo[num][1];
			main.enemyTeamRating = main.otherUserTeamInfo[num][3];
			main.enemyTeamBadge = main.otherUserTeamInfo[num][2];
			main.enemyTeamAbility = main.CharacterInfo[main.otherUserTeam[num][0]][6];
			
			main.gotoAndStop(6);
			
			main.removeChild(this);
		}
	}	
}
