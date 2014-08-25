package;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxMath;

/**
 * ...
 * @author damrem
 */
class Passenger extends Item 
{
	public var from:Planet;
	public var to:Planet;
	public function new(From:Planet, To:Planet) 
	{
		super('passenger');
		from = From;
		to = To;
	}
	
	public function getFare():UInt
	{
		return FlxMath.distanceBetween(from, to);
	}
	
}