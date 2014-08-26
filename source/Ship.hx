package ;

import flixel.addons.display.shapes.FlxShapeArrow;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.FlxSprite;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;
import flixel.util.FlxVelocity;

/**
 * ...
 * @author damrem
 */
class Ship extends FlxSprite
{
	public var fromPlanet:Planet;
	public var toPlanet:Planet;
	public var fuel:Float;
	public var isTravelling:Bool;
	
	public function new() 
	{
		super();
		//add(new FlxShapeCircle(0, -5, 5, { thickness:0, color:0xffffffff }, { hasFill:true, color:0xffffffff } ));
		loadGraphic("assets/images/ship.gif", true, 16, 32, true);
		
		animation.add('static', [0]);
		animation.add('burst', [1, 2], 5);
		
		//add(new FlxShapeBox(0, 0, 8, 12, { thickness:0, color:0xffffffff }, { hasFill:true, color:0xffffffff } ));
		//origin.x = offset.x = 8;
		//origin.y = offset.y = 16;
		//origin.x = origin.y = 8;
		//alpha = 0.5;
		fuel = 10000.0;
	}
	
	override public function update()
	{
		super.update();
		var vv:FlxVector = new FlxVector();
		vv.x = velocity.x;
		vv.y = velocity.y;
		
		
		angle = Math.round(vv.degrees / 90) * 90 + 90;
		if (vv.length == 0)	angle = vv.degrees;
	}
	
	public function burnFuel(distance:Float)
	{
		fuel -= distance;
	}
	
	public function setFromPlanet(FromPlanet:Planet) 
	{
		x = FromPlanet.x;
		y = FromPlanet.y;
		fromPlanet = toPlanet = FromPlanet;
	}
	
	public function land() 
	{
		//setGraphicSize(8, 16);
		//offset.x = -16;
		//offset.y = 16;
		animation.play('static');
	}
	
	public function takeOff() 
	{
		//setGraphicSize(16, 32);
		angle = 0;
		//offset.x = offset.y = 0;
		animation.play('burst');
	}
	
	/*
	function get_isTravelling():Bool
	{
		return velocity.x != 0 && velocity.y != 0;
	}
	
	public var isTravelling(get_isTravelling, null):Bool;
	*/
	
	
}