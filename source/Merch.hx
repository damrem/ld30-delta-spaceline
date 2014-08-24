package ;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author damrem
 */
class Merch extends FlxSpriteGroup
{
	public var name:String;
	public static var refPrices:Map<String, Float> = new Map<String, Float>();
	
	public function new(Name:String) 
	{
		super();
		name = Name;
	}
	
	function get_refPrice():Float 
	{
		return refPrices[name];
	}
	
	public var refPrice(get_refPrice, null):Float;
	
	
	
}