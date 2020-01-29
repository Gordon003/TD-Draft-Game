package Objects{
	
	import flash.display.*;
	import flash.filters.*;
	import flash.events.*;
	import flash.ui.*;
	import flash.geom.*;
	import flash.utils.Timer;
	
	public class MainClass extends MovieClip {
		
	//CHARACTER DATABASE
		//Character from each season
		public var Character:Array = new Array();
		//Info on each character
		public var CharacterInfo:Array = new Array();
		//Rating on each character
		public var CharacterRating:Array = new Array();
		//Each character's friend
		public var CharacterFriend:Array = new Array();
		//Each character's enemy
		public var CharacterEnemy:Array = new Array();
		//Badge Array
		public var badge:Array = new Array();
		
		//Selected Character
		public var firstCharSelected: String = "";	//First Character Selected
		public var secondCharSelected: String = ""; //Second Character Selected
		
		public var userAction: String = "Nothing";

		public var challenge: String;
		
		public var visited: String = "no";
		
		/* 
			0 - All Golds
			1 - 3 Golds 3 Silvers
			2 - All Silvers
			3 - All Bronzes
		*/
		public var cardTypeNumber: Array = new Array();
		
	//CHALLENGE DATABASE
		//Challenge List
		public var ChallengeList: Array = new Array();
		//Challenge Info
		public var ChallengeInfo:Array = new Array();
		//Attributes required for each challenge
		public var ChallengeAttributes:Array = new Array();
		//Abilities List
		public var AbilityList: Array = new Array()
		
		//User
		public var user: String;
		public var userTeam: Array = new Array();
		public var userTeamName: String = "";
		public var userTeamRating: Number = 0;
		public var userTeamChemistry: Number = 0;
		public var userTeamBadge: String = "";
		public var userTeamRoundScore: Number = 0;
		public var userTeamChallengeScore: Number = 0;
		public var userTeamWin: Number = 0;
		public var userTeamDraw: Number = 0;
		public var userTeamLoss: Number = 0;
		public var userTeamAbility: String = "None";
		
		//Enemy
		public var enemy: String;
		public var enemyTeam: Array = new Array();
		public var enemyTeamName: String;
		public var enemyTeamRating: Number;
		public var enemyTeamBadge: String;
		public var enemyTeamRoundScore: Number = 0;
		public var enemyTeamChallengeScore: Number = 0;
		public var enemyTeamAbility: String = "None";

	//ENEMY DATABASE
		public var otherUser: Array = new Array();
		public var otherUserTeam: Array = new Array();
		public var otherUserTeamInfo: Array = new Array();
	
	//ORIGINAL TEAM DATABASE
		public var originalTeam: Array = new Array();
		public var originalTeamInfo: Array = new Array();
		
	//GAME
		public var roundNumber: Number = 1;
		public var challengeNumber: Number = 1;
		public var numPlayer: Number = 0;
		public var numPlayerLeft: Number = 9;
		public var teamBattle: Array = new Array();
		
	//Background PNG Array
		public var backgroundArray: Array = new Array();
		public var backgroundNum: Number = 0;
		
	//Draft
		public var chem: Array = new Array();
		public var teamCard:Array = new Array();
		public var cardSelected = null;
		
		public var formAppear;	//Check if there is another open form
		
	//Constructor Function
		public function MainClass() {
			teamBattle["User"] = [];
			teamBattle["Enemy"] = [];
		}
		
	}		
}
