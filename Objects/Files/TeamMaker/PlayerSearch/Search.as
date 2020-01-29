btnSearch.addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).HoverSelected);
btnSearch.addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).LeaveSelected);
btnSearch.addEventListener(MouseEvent.CLICK, Search);
function Search(e:MouseEvent):void{
	for (var K: int = 0; K < CardSearch.length; K++){
		CardSearch[K].filters = [];
		CardSearch[K].addEventListener(MouseEvent.MOUSE_OVER, MovieClip(root).Hover);
		CardSearch[K].addEventListener(MouseEvent.MOUSE_OUT, MovieClip(root).Leave);
		CardSearch[K].addEventListener(MouseEvent.CLICK, CardSelected);
	}
	
	SearchResult = [];
	SortedResult = [];
	
	var Check: Array = new Array();
	Check[0] = ["Bronze", "Silver", "Gold"];
	Check[1] = ["TDI", "TDA", "TDWT", "TDROTI", "TDAS", "TDPI", "TDRR"];
	
	if (CardFormSelected == "Gold"){
		Check[0] = ["Gold"];
	}
	else if (CardFormSelected == "Silver"){
		Check[0] = ["Silver"];
	}
	else if (CardFormSelected == "Bronze"){
		Check[0] = ["Bronze"];
	}
	
	if (SeasonSelected == "[object tdi]"){
		Check[1] = ["TDI"];
	}
	else if (SeasonSelected == "[object tda]"){
		Check[1] = ["TDA"];
	}
	else if (SeasonSelected == "[object tdwt]"){
		Check[1] = ["TDWT"];
	}
	else if (SeasonSelected == "[object tdroti]"){
		Check[1] = ["TDROTI"];
	}
	else if (SeasonSelected == "[object tdas]"){
		Check[1] = ["TDAS"];
	}
	else if (SeasonSelected == "[object tdpi]"){
		Check[1] = ["TDPI"];
	}
	else if (SeasonSelected == "[object rr]"){
		Check[1] = ["TDRR"];
	}

	for (var b: int = 0; b < Check[0].length; b++){
		for (var c: int = 0; c < Check[1].length; c++){
			var Total: String = Check[0][b] + Check[1][c];	//e.g. "BronzeTDI"
			for (var d:int = 0; d < MovieClip(root).Character[Total].length; d++){
				SearchResult.push(MovieClip(root).Character[Total][d]);
			}
		}
	}
	
	//Sort Array based on rating
	var SearchLength = SearchResult.length;
	for (var E: int = 0; E < SearchLength; E++){
		var HighPlayer
		var HighRating: Number = 0;
		var HighestVar: Number;
		for (var F: int = 0; F < SearchResult.length; F++){
			var Player = SearchResult[F];
			var PlayerRating = MovieClip(root).CharacterRating[Player][0];
			if (PlayerRating >= HighRating){
				HighPlayer = Player;
				HighRating = PlayerRating;
				HighestVar = F;
			}
		}
		SortedResult.push(HighPlayer);
		SearchResult.splice(HighestVar,1);
	}
	
	if (lblName.text != "any"){
		var NameChecked = "True";
		do{
			NameChecked = "True";
			for (var H: int = 0; H < SortedResult.length; H++){
				if (SortedResult[H].indexOf(NameSelected) == -1){
					SortedResult.splice(H, 1);
					NameChecked = "False";
				}
			}
		} while (NameChecked == "False");
	}
	
	//Display Result
	SearchLength = SortedResult.length;
	for (var G: int = 0; G < CardSearch.length; G++){
		CardSearch[G].filters = [];
		if (G < SearchLength){
			CardSearch[G].Load(SortedResult[G]);
			CardSearch[G].visible = true;
		}
		else{
			CardSearch[G].visible = false;
		}
	}
	
	NumPage = 1;
	lblPage.text = "Page 1"
	
	if (SearchLength <= 5){
		Right.visible = false;
	}
	else{
		Right.visible = true;
	}
	Left.visible = false;
	
	lblNoResult.visible = false;
	if (SearchLength == 0){
		lblNoResult.visible = true;
	}
	
	btnInfo.visible = false;
	btnSelect.visible = false;
}