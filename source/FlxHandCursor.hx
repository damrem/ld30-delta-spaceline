package ;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.plugin.MouseEventManager;

/**
 * ...
 * @author damrem
 */
class FlxHandCursor
{

	public static function set(obj:FlxObject) 
	{
		MouseEventManager.add(obj);
		MouseEventManager.setMouseOverCallback(addHandCursor);
		MouseEventManager.setMouseOutCallback(removeHandCursor);
	}
	
	static private function removeHandCursor(obj:FlxObject) 
	{
		FlxG.mouse.setSimpleNativeCursorData(
	}
	
	static private function addHandCursor() 
	{
		
	}
	
}