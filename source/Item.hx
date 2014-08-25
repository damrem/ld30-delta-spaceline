package ;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author damrem
 */
class Item extends FlxSpriteGroup
{
	public var name:String;
	
	public function new(Name:String) 
	{
		super();
		name = Name;
	}
	
}