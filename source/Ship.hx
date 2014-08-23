package ;

import flixel.FlxSprite;

/**
 * ...
 * @author damrem
 */
class Ship extends FlxSprite
{
	public var fromPlanet:Planet;
	public var toPlanet:Planet;
	public var fuel:Float;
	private var _isTravelling:Bool;
	
	public function new(FromPlanet:Planet) 
	{
		super(FromPlanet.x, FromPlanet.y);
		//centerOrigin();
		centerOffsets();
		fromPlanet = toPlanet = FromPlanet;
		alpha = 0.5;
		fuel = 10000.0;
	}
	
	function move()
	{
		
	}
	
	public function burnFuel(distance:Float)
	{
		fuel -= distance;
	}
	
	function get_isTravelling():Bool
	{
		return velocity.x != 0 && velocity.y != 0;
	}
	
	public var isTravelling(get_isTravelling, null):Bool;
	
}