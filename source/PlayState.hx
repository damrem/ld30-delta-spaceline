package ;

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
	//var ships:FlxSpriteGroup;
	var ship:Ship;
	var planets:FlxSpriteGroup;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		
		MouseEventManager.init();
		
		var food:MercInUniv = new MercInUniv('food', 10.0);
		var fuel:MercInUniv = new MercInUniv('fuel', 25.0);
		var cloth:MercInUniv = new MercInUniv('cloth', 15.0);
		var metal:MercInUniv = new MercInUniv('metal', 20.0);
		
		planets = new FlxSpriteGroup(0, 0, 10000);
		add(planets);

		var planet1 = new Planet(200, 100);
		planet1.addMerchandiseType(new MercOnPlanet(food, 10, 0.5));
		planets.add(planet1);

		var planet2 = new Planet(100, 350);
		planets.add(planet2);

		var planet3 = new Planet(250, 250);
		planets.add(planet3);
		trace(planet3);
		
		//ships = new FlxSpriteGroup();
		//add(ships);
		
		ship = new Ship(planet1);
		add(ship);
		
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
		
		moveShip();
	}
	
	function moveShip()
	{
		if (ship.toPlanet == ship.fromPlanet)
		{
			trace("return");
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
			ship.acceleration.set(travelStep.x, travelStep.y);
		}
		//	arriving
		else if(travelledDist > distToTravel)
		{
			trace("arriving");
			ship.acceleration.set(0, 0);
			ship.velocity.set(0, 0);
			ship.setPosition(ship.toPlanet.x, ship.toPlanet.y);
			ship.fromPlanet = ship.toPlanet;
			//ship.velocity.set(travelStep.x, travelStep.y);
		}
		
		//var distance = FlxMath.distanceBetween(ship.from, ship.to);
		//trace(travelledDist);
		
	}
}




enum MerchandiseName
{
	Food;
	Metal;
	Fuel;
	Cloth;
}
	
