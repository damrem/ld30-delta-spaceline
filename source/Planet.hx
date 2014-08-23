package ;
import flash.display.Sprite;
import flixel.text.FlxTextField;
import MercOnPlanet;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxRandom;
/**
 * ...
 * @author damrem
 */
class Planet extends FlxSpriteGroup
{	
	var mercs:Array<MercOnPlanet>;
	public var body:FlxSprite;
	var infos:FlxTextField;
	
	public function new(X:Int, Y:Int) 
	{
		super(X, Y, 10);
		MouseEventManager.add(this);
		
		mercs = new Array<MercOnPlanet>();
		
		body = new FlxSprite();
		centerOrigin();
		trace("body", body);
		origin.x = 8;
		origin.y = 8;
		add(body);
		
		infos = new FlxTextField(10, 10, 100, mercs.toString());
		add(infos);
	}
	
	public function work()
	{
		if (FlxRandom.chanceRoll(10))
		{
			
		}
	}
	
	public function addMerchandiseType(type:MercOnPlanet)
	{
		mercs.push(type);
		infos.text = mercs.toString();
	}
	
}