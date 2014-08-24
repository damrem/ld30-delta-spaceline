package ;

import flash.display.BitmapData;
import flash.Lib;
import flixel.addons.display.shapes.FlxShapeCross;
import flixel.addons.display.shapes.FlxShapeSquareDonut;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxBitmapUtil;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import flixel.util.FlxVector;
import flixel.addons.display.FlxNestedSprite;
/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	var t_sec:Float;
	var t_lastFullSec:Int;
	var ship:Ship;
	var planets:FlxSpriteGroup;
	var merchs:Array<MerchInUniv>;
	
	var inventory:Inventory;
	public static var market:Market;
	public static var currentPlanet:Planet;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		
		MouseEventManager.init();
		
		var bg:FlxSpriteGroup = new FlxSpriteGroup();

		var bmp:BitmapData = new BitmapData(640, 480);
		var perlin:OptimizedPerlin = new OptimizedPerlin();
		//perlin.fill(bmp, 0, 0, 0);
		var farfaraway = new FlxSprite(0, 0, bmp);
		farfaraway.alpha = 0.15;
		bg.add(farfaraway);
		
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
		
		//var food:MerchInUniv = new MerchInUniv('Food');
		Merch.refPrices['Food'] = 100;
		Merch.refPrices['Metal'] = 150;
		Merch.refPrices['Weapon'] = 200;
		Merch.refPrices['Crystal'] = 500;
		//var fuel:MerchInUniv = new MerchInUniv('StarFuel', 250.0);
		//var cloth:MerchInUniv = new MerchInUniv('Cloth', 150.0);
		//var metal:MerchInUniv = new MerchInUniv('Metal', 200.0);
		
		ship = new Ship();
		
		inventory = new Inventory(ship);
		
		market = new Market();
		market.x = market.y = 10;
		add(market);
		
		planets = new FlxSpriteGroup(150, 0, 10000);
		add(planets);

		var planet1 = new Planet("Dhirsononn", 200, 100);
		planet1.addMerchType(new MerchOnPlanet('Food', 50));
		planet1.addMerchType(new MerchOnPlanet('Metal', 10));
		planet1.addMerchType(new MerchOnPlanet('Weapon', 0));
		planet1.addMerchType(new MerchOnPlanet('Crystal', 100));
		planets.add(planet1);
		MouseEventManager.setMouseUpCallback(planet1, selectPlanet);

		var planet2 = new Planet("Kenti", 100, 350);
		planet2.alpha = 0.25;
		planet2.addMerchType(new MerchOnPlanet('Food', 20));
		planet2.addMerchType(new MerchOnPlanet('Metal', 100));
		planet2.addMerchType(new MerchOnPlanet('Weapon', 40));
		planet2.addMerchType(new MerchOnPlanet('Crystal', 0));
		planets.add(planet2);
		MouseEventManager.setMouseUpCallback(planet2, selectPlanet);

		var planet3 = new Planet("Bastion", 250, 250);
		planet3.alpha = 0.25;
		planet3.addMerchType(new MerchOnPlanet('Food', 100));
		planet3.addMerchType(new MerchOnPlanet('Metal', 50));
		planet3.addMerchType(new MerchOnPlanet('Weapon', 00));
		planet3.addMerchType(new MerchOnPlanet('Crystal', 0));
		planets.add(planet3);
		MouseEventManager.setMouseUpCallback(planet3, selectPlanet);
		
		ship.setFromPlanet(planet1);
		add(ship);
		currentPlanet = planet1;
		market.setPlanet(planet1);
		
		
		
		inventory.x = FlxG.stage.stageWidth - inventory.width - 10;
		inventory.y = 10;
		//inventory.updateFuel();
		add(inventory);
		
		
		
		
	}
	
	function selectPlanet(to:FlxObject)
	{
		//trace("selectPlanet(" + to);
		if (!ship.isTravelling)
		{
			var planet:Planet = cast(to);
			//trace(to);
			ship.toPlanet = planet;
		}
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
		
		t_sec = Lib.getTimer() / 1000;
		if (Math.floor(t_sec) > t_lastFullSec)
		{
			t_lastFullSec = Math.floor(t_sec);
			tick();
		}
		
		moveShip();
	}
	
	function tick()
	{
		//planets.callAll('work');
	}
	
	function moveShip()
	{
		if (ship.toPlanet == ship.fromPlanet)
		{
			return;
		}
		
		//if the ship is departing, we use the energy necessary to the trip
		var travelledDist = FlxMath.distanceBetween(ship.fromPlanet, ship);
		/*
		trace("travelledDist", travelledDist);
		trace(ship.fromPlanet.x, ship.fromPlanet.y, ship.fromPlanet.origin);
		trace(ship.x, ship.y, ship.origin);
		*/
		
		var distToTravel = FlxMath.distanceBetween(ship.fromPlanet, ship.toPlanet);
		//trace("distToTravel", distToTravel);
		
		var travelStep = FlxVector.get(ship.toPlanet.x - ship.fromPlanet.x, ship.toPlanet.y - ship.fromPlanet.y);
		//travelStep.scale(4);
		//trace("travelStep", travelStep);
		
		//	departing
		if (travelledDist == 0 && !ship.isTravelling && ship.fuel >= distToTravel)
		{
			//trace("departing");
			//trace("ship", ship);
			inventory.addCredits( -distToTravel);
			ship.acceleration.set(travelStep.x, travelStep.y);
			market.visible = false;
			currentPlanet.alpha = 0.25;
		}
		//	arriving
		else if(travelledDist > distToTravel)
		{
			//trace("arriving");
			ship.acceleration.set(0, 0);
			ship.velocity.set(0, 0);
			ship.setPosition(ship.toPlanet.x, ship.toPlanet.y);
			ship.fromPlanet = ship.toPlanet;
			currentPlanet = ship.toPlanet;
			currentPlanet.alpha = 1.0;
			market.setPlanet(currentPlanet);
			market.visible = true;
		}
		
	}
}

	
