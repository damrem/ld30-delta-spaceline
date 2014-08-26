package;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
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
		
		MouseEventManager.add(this);
		MouseEventManager.setMouseOverCallback(this, highlightDest);
		MouseEventManager.setMouseOutCallback(this, downlightDest);
	}
	
	function highlightDest(passenger:FlxSprite) 
	{
		trace("highlightDest");
		to.highlight(0.75);
	}
	
	function downlightDest(passenger:FlxSprite) 
	{
		trace("downlightDest");
		to.downlight();
	}
	
	public function getFare():UInt
	{
		return FlxMath.distanceBetween(from, to);
	}
	
}