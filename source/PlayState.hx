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
	var currentMarket:Market;
	var trader:Trader;
	
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
		perlin.fill(bmp, 0, 0, 0);
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
		
		var food:MerchInUniv = new MerchInUniv('Food', 100.0);
		//var fuel:MerchInUniv = new MerchInUniv('StarFuel', 250.0);
		var cloth:MerchInUniv = new MerchInUniv('Cloth', 150.0);
		var metal:MerchInUniv = new MerchInUniv('Metal', 200.0);
		
		ship = new Ship();
		
		inventory = new Inventory(ship);
		inventory.addMerchType(new MerchInInventory(food));
		inventory.addMerchType(new MerchInInventory(cloth));
		inventory.addMerchType(new MerchInInventory(metal));
		
		trader = new Trader(currentMarket, inventory);
		
		planets = new FlxSpriteGroup(150, 0, 10000);
		add(planets);

		var planet1 = new Planet("Dhirsononn", 200, 100, trader);
		planet1.addMerchType(new MerchOnPlanet(cloth, 1000, trader));
		planet1.addMerchType(new MerchOnPlanet(food, 500, trader));
		planet1.addMerchType(new MerchOnPlanet(metal, 0, trader));
		planets.add(planet1);

		var planet2 = new Planet("Kenti", 100, 350, trader);
		planet2.addMerchType(new MerchOnPlanet(metal, 1000, trader));
		planet2.addMerchType(new MerchOnPlanet(cloth, 200, trader));
		planet2.addMerchType(new MerchOnPlanet(food, 0, trader));
		planets.add(planet2);

		var planet3 = new Planet("Bastion", 250, 250, trader);
		planet3.addMerchType(new MerchOnPlanet(food, 1000, trader));
		planet3.addMerchType(new MerchOnPlanet(metal, 50, trader));
		planet3.addMerchType(new MerchOnPlanet(cloth, 0, trader));
		planets.add(planet3);
		
		ship.setFromPlanet(planet1);
		add(ship);
		currentMarket = planet1.market;
		add(currentMarket);
		
		
		inventory.x = FlxG.stage.stageWidth - inventory.width - 10;
		inventory.y = 10;
		inventory.updateFuel();
		add(inventory);
		
		MouseEventManager.setMouseUpCallback(planet1, selectPlanet);
		MouseEventManager.setMouseUpCallback(planet2, selectPlanet);
		MouseEventManager.setMouseUpCallback(planet3, selectPlanet);
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
		planets.callAll('work');
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
			ship.burnFuel(distToTravel);
			inventory.updateFuel();
			ship.acceleration.set(travelStep.x, travelStep.y);
			remove(currentMarket);
		}
		//	arriving
		else if(travelledDist > distToTravel)
		{
			//trace("arriving");
			ship.acceleration.set(0, 0);
			ship.velocity.set(0, 0);
			ship.setPosition(ship.toPlanet.x, ship.toPlanet.y);
			ship.fromPlanet = ship.toPlanet;
			currentMarket = ship.toPlanet.market;
			add(currentMarket);
		}
		
	}
}

	
