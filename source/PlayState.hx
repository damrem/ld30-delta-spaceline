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
import flixel.input.keyboard.FlxKey;
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
	var space:FlxSpriteGroup;
	
	var inventory:Inventory;
	public static var market:Market;
	public static var currentPlanet:Planet;
	
	/**
	 * Function that is called up when to state is created to set it up.
	 */
	override public function create():Void
	{
		super.create();
		
		FlxG.sound.playMusic("assets/music/Space Machine A.mp3");
		FlxG.sound.muteKeys = ["m", "M", "0"];
		
		MouseEventManager.init();
		
		space = new FlxSpriteGroup();
		
		var bg:FlxSpriteGroup = new FlxSpriteGroup();
		
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
		
		add(space);
		
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
		space.add(planets);
		
		var names = [
			"Ban",
			"Kenti",
			"Dhirsononn",
			"Oflag",
			"Lekkos",
			"Arch",
			"Benthis",
			"Krass",
			"Bastion",
			"Humus",
			"Kron",
			"Warlus",
			"Adansonia",
			"Calanque",
			"Palafitte",
			"Primon",
			"Balunkri",
			"Mekyeff",
			"Magyalai",
			"Sundh'Bal",
			"Zeehen",
			"Chasm",
			"Lithiq",
			"Palud",
			"Hobah",
			"Hypogea"
		];
		names = FlxRandom.shuffleArray(names, names.length * 3);
		var listPlanets = new Array<Planet>();
		var i:UInt = 0;
		for (col in 0...3)
		{
			for (row in 0...4)
			{
				if (FlxRandom.chanceRoll(75))
				{
					//trace(i);
					var left = Std.int(col * 330 / 3) + 30;
					var right = Std.int((col+1) * 340 / 3) - 30;
					var X = FlxRandom.intRanged(left, right);
					
					var top = Std.int(row * 440 / 4) + 30;
					var down = Std.int((row+1) * 480 / 4) - 30;
					var Y = FlxRandom.intRanged(top, down);
					
					var planet = new Planet(names[i], X, Y);
					planet.downlight();
					planet.addMerchType(new MerchOnPlanet('Food', FlxRandom.intRanged(1, 25)));
					planet.addMerchType(new MerchOnPlanet('Metal', FlxRandom.intRanged(0, 20)));
					planet.addMerchType(new MerchOnPlanet('Weapon', FlxRandom.intRanged(0, 10)));
					planet.addMerchType(new MerchOnPlanet('Crystal', FlxRandom.intRanged(0, 5)));
					planets.add(planet);
					MouseEventManager.setMouseUpCallback(planet, selectPlanet);
					//MouseEventManager.setMouseOverCallback(planet, planet.hightlight);
					//MouseEventManager.setMouseOutCallback(planet, planet.downlight);
					listPlanets.push(planet);
					i++;
				}
			}
		}
		
		var nbPlanets = FlxRandom.intRanged(8, 12);
		
		
		listPlanets = FlxRandom.shuffleArray(listPlanets, listPlanets.length * 3);
		ship.setFromPlanet(listPlanets[0]);
		space.add(ship);
		currentPlanet = listPlanets[0];
		currentPlanet.hightlight();
		market.setPlanet(listPlanets[0]);
		
		
		
		inventory.x = FlxG.stage.stageWidth - inventory.width - 10;
		inventory.y = 10;
		//inventory.updateFuel();
		add(inventory);
		
		
		//FlxG.camera.follow(FlxG.mouse.
		
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
	var tickCount:UInt;
	override public function update():Void
	{
		super.update();
		
		t_sec = Lib.getTimer() / 1000;
		if (Math.floor(t_sec) > t_lastFullSec)
		{
			t_lastFullSec = Math.floor(t_sec);
			if (tickCount % 5 == 0)	tick();
			tickCount++;
		}
		
		//trace(t_sec);
		//trace(t_lastFullSec);
		
		moveShip();
		
		space.x = ( - (FlxG.mouse.x - 320) / 10);
		space.y = ( - (FlxG.mouse.y - 240) / 10);
	}
	
	function tick()
	{
		trace("tick");
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
			inventory.addCredits( -distToTravel);
			ship.acceleration.set(travelStep.x, travelStep.y);
			market.visible = false;
			currentPlanet.downlight();
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
			currentPlanet.hightlight();
			market.setPlanet(currentPlanet);
			market.visible = true;
		}
		
	}
}

	
