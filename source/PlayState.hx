package ;

import flash.Lib;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxMath;
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
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		
		MouseEventManager.init();
		
		var food:MerchInUniv = new MerchInUniv('Food', 100.0);
		//var fuel:MerchInUniv = new MerchInUniv('StarFuel', 250.0);
		var cloth:MerchInUniv = new MerchInUniv('Cloth', 150.0);
		var metal:MerchInUniv = new MerchInUniv('Metal', 200.0);
		
		planets = new FlxSpriteGroup(150, 0, 10000);
		add(planets);

		var planet1 = new Planet("Dhirsononn", 200, 100);
		planet1.addMerch(new MerchOnPlanet(food, 500));
		planet1.addMerch(new MerchOnPlanet(cloth, 1000));
		planets.add(planet1);

		var planet2 = new Planet("Kenti", 100, 350);
		planet2.addMerch(new MerchOnPlanet(cloth, 200));
		planet2.addMerch(new MerchOnPlanet(metal, 1000));
		planets.add(planet2);

		var planet3 = new Planet("Bastion", 250, 250);
		planet3.addMerch(new MerchOnPlanet(metal, 50));
		planet3.addMerch(new MerchOnPlanet(food, 1000));
		planets.add(planet3);
		trace(planet3);
		
		//ships = new FlxSpriteGroup();
		//add(ships);
		
		ship = new Ship(planet1);
		add(ship);
		currentMarket = planet1.market;
		add(currentMarket);
		
		inventory = new Inventory(ship);
		inventory.x = FlxG.stage.stageWidth - inventory.width;
		add(inventory);
		
		MouseEventManager.setMouseUpCallback(planet1, selectPlanet);
		MouseEventManager.setMouseUpCallback(planet2, selectPlanet);
		MouseEventManager.setMouseUpCallback(planet3, selectPlanet);
	}
	
	function selectPlanet(to:FlxObject)
	{
		trace("selectPlanet(" + to);
		if (!ship.isTravelling)
		{
			var planet:Planet = cast(to);
			trace(to);
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
		trace("travelledDist", travelledDist);
		trace(ship.fromPlanet.x, ship.fromPlanet.y, ship.fromPlanet.origin);
		trace(ship.x, ship.y, ship.origin);
		
		var distToTravel = FlxMath.distanceBetween(ship.fromPlanet, ship.toPlanet);
		trace("distToTravel", distToTravel);
		
		var travelStep = FlxVector.get(ship.toPlanet.x - ship.fromPlanet.x, ship.toPlanet.y - ship.fromPlanet.y);
		travelStep.scale(4);
		trace("travelStep", travelStep);
		
		//	departing
		trace(ship.fromPlanet, ship.x, ship.y);
		trace(!ship.isTravelling);
		trace(ship.fuel >= distToTravel);
		if (travelledDist == 0 && !ship.isTravelling && ship.fuel >= distToTravel)
		{
			trace("departing");
			ship.burnFuel(distToTravel);
			inventory.updateFuel();
			ship.acceleration.set(travelStep.x, travelStep.y);
			remove(currentMarket);
		}
		//	arriving
		else if(travelledDist > distToTravel)
		{
			trace("arriving");
			ship.acceleration.set(0, 0);
			ship.velocity.set(0, 0);
			ship.setPosition(ship.toPlanet.x, ship.toPlanet.y);
			ship.fromPlanet = ship.toPlanet;
			currentMarket = ship.toPlanet.market;
			add(currentMarket);
		}
		
	}
}




enum MerchandiseName
{
	Food;
	Metal;
	Fuel;
	Cloth;
}
	
