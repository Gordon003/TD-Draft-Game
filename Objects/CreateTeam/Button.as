/*
btnSelectChar.addEventListener(MouseEvent.CLICK, option);
function option(e:MouseEvent):void{
	var charForm: CharSelectForm = new CharSelectForm();
	MovieClip(root).addChildAt(charForm, MovieClip(root).numChildren);
	charForm.x = 524.85;
	charForm.y = 301.35;
	charForm.height = 312.4;
	charForm.width = 638.6;
}
*/

/*Help Button
	Tell user how to play*/
import Objects.Draft.DraftHelp;
btnHelp.addEventListener(MouseEvent.CLICK, help);
function help(e:MouseEvent):void{
	var helpForm: DraftHelp = new DraftHelp();
	addChildAt(helpForm, numChildren);
	helpForm.x = 230;
	helpForm.y = 165;
	helpForm.height = 330;
	helpForm.width = 590;
	helpForm.name = "Appeared";
	formAppear = helpForm.name;
}