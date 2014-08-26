package ;

import flixel.addons.display.shapes.FlxShapeCross;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.util.FlxRandom;

/**
 * ...
 * @author damrem
 */
class VictoryState extends FlxState
{
	var travelsLabel:FlxText;
	var nbTravels:UInt;
	
	public function new(NbTravels:UInt)
	{
		super();
		nbTravels = NbTravels;
	}

	override public function create() 
	{
		super.create();
		
		var bg = new StarBackground(FlxG.stage.stageWidth, FlxG.stage.stageHeight);
		add(bg);
		
		var victory = new FlxText(0, 200, FlxG.stage.stageWidth, "Victory!!!", 16);
		victory.color = 0xffff00;
		victory.alignment = 'center';
		add(victory);
		
		travelsLabel = new FlxText(0, 250, FlxG.stage.stageWidth, "You won in " + nbTravels + " travels... Congrats!", 16);
		travelsLabel.color = 0xffffff;
		travelsLabel.alignment = 'center';
		add(travelsLabel);
		
		MouseEventManager.add(bg);
		MouseEventManager.setMouseUpCallback(bg, next);
	}
	
	function next(obj:FlxSpriteGroup)
	{
		//trace("start");
		//FlxG.switchState(new MenuState());
	}
	
	public function setNbTravels(nbTravels)
	{
		travelsLabel.text = "You won in " + nbTravels + " travels... Congrats!";
	}
	
	
}