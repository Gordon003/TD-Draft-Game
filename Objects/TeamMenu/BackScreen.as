package Objects.TeamMenu {
	
	import flash.display.MovieClip;
	
	
	public class BackScreen extends MovieClip {
		
		//Construction function
		public function BackScreen() {
		}
		
		public function loadSummary(){
			lblName.text = MovieClip(root).userTeamName;
			lblRating.text = MovieClip(root).userTeamRating;
			lblChem.text = MovieClip(root).userTeamChemistry + "%";
			lblRecord.text = MovieClip(root).userTeamWin + "W/" + MovieClip(root).userTeamDraw + "D/" + MovieClip(root).userTeamLoss + "L";
			Leader.loadCharacter(MovieClip(root).userTeam[0]);
		}
	}
	
}
