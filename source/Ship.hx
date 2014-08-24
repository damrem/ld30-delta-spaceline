package ;

import flixel.addons.display.shapes.FlxShapeArrow;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxPoint;
import flixel.util.FlxVector;
import flixel.util.FlxVelocity;

/**
 * ...
 * @author damrem
 */
class Ship extends FlxSpriteGroup
{
	public var fromPlanet:Planet;
	public var toPlanet:Planet;
	public var fuel:Float;
	private var _isTravelling:Bool;
	
	public function new() 
	{
		super();
		//add(new FlxShapeCircle(0, -5, 5, { thickness:0, color:0xffffffff }, { hasFill:true, color:0xffffffff } ));
		add(new FlxShapeBox(0, 0, 8, 12, { thickness:0, color:0xffffffff }, { hasFill:true, color:0xffffffff } ));
		offset.x = 4;
		offset.y = 6;
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
		angle = vv.degrees + 90;
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
	
	function get_isTravelling():Bool
	{
		return velocity.x != 0 && velocity.y != 0;
	}
	
	public var isTravelling(get_isTravelling, null):Bool;
	
}