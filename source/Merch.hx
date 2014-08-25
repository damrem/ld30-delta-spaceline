package ;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author damrem
 */
class Merch extends Item
{
	public static var refPrices:Map<String, Float> = new Map<String, Float>();
	//public var icon:FlxSprite;
	
	public function new(Name:String) 
	{
		super(Name);
		
		
		//icon = new FlxSprite(0, 0);
		//trace(name.toLowerCase());
		//icon.loadGraphic("assets/images/" + name.toLowerCase() + ".gif");
	}
	
	function get_refPrice():Float 
	{
		return refPrices[name];
	}
	
	public var refPrice(get_refPrice, null):Float;
	
	public function getNewIcon():FlxSprite
	{
		var icon = new FlxSprite();
		//trace(name.toLowerCase());
		icon.loadGraphic("assets/images/" + name.toLowerCase() + ".gif");
		return icon;
	}
	
}