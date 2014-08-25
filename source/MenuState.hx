package ;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeCross;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		//trace("create");
		super.create();
		
		FlxG.sound.playMusic("assets/music/Space Machine A.mp3");
		FlxG.sound.muteKeys = ["m", "M", "0"];
		
		var bg:FlxSpriteGroup = new FlxSpriteGroup();
		
		bg.add(new FlxShapeBox(0, 0, 640, 480, 
		{ thickness:0, color:0x000000, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, 
		{ hasFill:true, color:0xff000000 } ));

		for (i in 0...100)
		{
			var starlength:UInt = FlxRandom.intRanged(1, 5);
			var starsize:UInt = FlxRandom.intRanged(0, 1);
			var star:FlxShapeCross = new FlxShapeCross(FlxRandom.intRanged(0, 640), FlxRandom.intRanged(0, 480),
			starlength, starsize, starlength, starsize, 0.5, 0.5, 
			{ thickness: 0, color:0x00000000 }, { hasFill:true, color:0xffffffff } );
			star.alpha = FlxRandom.intRanged(0, 1);
			bg.add(star);
		}
		add(bg);
		
		var title = new FlxText(0, 75, 640, "DELTA SPACELINE", 32);
		title.alignment = 'center';
		title.color = 0xffff00;
		add(title);
		
		var subtitle = new FlxText(0, 115, 640, "A space trading game.", 12);
		subtitle.alignment = 'center';
		//title.color = 0xffff00;
		add(subtitle);
		
		var objective = new FlxText(10, 175, FlxG.stage.stageWidth - 20, "Objective: gather 10,000     within the minimum amount of travels!", 12);
		objective.alignment = 'center';
		add(objective);
		
		var coin = new FlxSprite(257, objective.y);
		coin.loadGraphic("assets/images/coin.gif");
		
		var help = new FlxText(0, 250, 640, "Click to Start - M: Mute", 16);
		help.alignment = 'center';
		add(help);
		
		var tutorial = new FlxText(200, 325, 440, "Travel aboard your ship by clicking on planets!\nTrade merchandises!\nCheck price trends!\nBuy cheap!\nSell hard!\nCarry passengers to optimize your moves!", 12);
		
		var ship = new FlxSprite(tutorial.x - 18, tutorial.y - 12);
		ship.loadGraphic("assets/images/ship.gif", true, 16, 32);
		
		var merchs = new FlxSpriteGroup(tutorial.x - 77, tutorial.y + 16);
		
		var trends = new FlxSpriteGroup(tutorial.x - 87, tutorial.y + 34);
				
		var t1 = new FlxSprite(72);
		t1.loadGraphic("assets/images/upup.gif");
		trends.add(t1);
		
		var t2 = new FlxSprite(54);
		t2.loadGraphic("assets/images/up.gif");
		trends.add(t2);
		var t3 = new FlxSprite(36);
		t3.loadGraphic("assets/images/eq.gif");
		trends.add(t3);
		
		var t4 = new FlxSprite(18);
		t4.loadGraphic("assets/images/dn.gif");
		trends.add(t4);
		
		var t5 = new FlxSprite();
		t5.loadGraphic("assets/images/dndn.gif");
		trends.add(t5);
		
		var t5b = new FlxSprite(tutorial.x - 15, tutorial.y + 50);
		t5b.loadGraphic("assets/images/dndn.gif");

		var t1b = new FlxSprite(tutorial.x -15, tutorial.y + 64);
		t1b.loadGraphic("assets/images/upup.gif");
		

		var food = new FlxSprite();
		food.loadGraphic("assets/images/food.gif");
		merchs.add(food);
		
		var metal = new FlxSprite(20);
		metal.loadGraphic("assets/images/metal.gif");
		merchs.add(metal);
		
		var weapon = new FlxSprite(40);
		weapon.loadGraphic("assets/images/weapon.gif");
		merchs.add(weapon);
		
		var crystal = new FlxSprite(60);
		crystal.loadGraphic("assets/images/crystal.gif");
		merchs.add(crystal);
		
		var passenger = new FlxSprite(tutorial.x - 18, tutorial.y + 75);
		passenger.loadGraphic("assets/images/passenger.gif");
		
		var credits = new FlxText(0, 450, 640, "Made in 72h by @damrem for Ludum Dare 30: 'Connected Worlds'.\nSome graphics by Arachne on TIGsource - Music by Kevin MacLeod - Incompetech.com");
		credits.alignment = 'center';
		add(credits);
		
		
		
		add(tutorial);
		add(ship);
		add(merchs);
		add(trends);
		add(t1b);
		add(t5b);
		add(passenger);
		add(coin);
		
		MouseEventManager.init();
		MouseEventManager.add(bg);
		MouseEventManager.setMouseUpCallback(bg, start);
	}
	
	function start(obj:FlxSpriteGroup)
	{
		//trace("start");
		FlxG.switchState(new PlayState());
	}

	/**
	 * Function that is called when this state is destroyed - you might want to
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}
}