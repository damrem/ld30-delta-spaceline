package ;
import flash.display.Sprite;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import MerchOnPlanet;
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
	public var name:String;
	var nameLabel:FlxText;
	public var merchs:Array<MerchOnPlanet>;
	var body:FlxSprite;
	var infLabel:FlxText;
	public var market:Market;
	
	public function new(Name:String, X:Int, Y:Int) 
	{
		super(X, Y, 10);
		
		name = Name;
		
		MouseEventManager.add(this);
		
		merchs = new Array<MerchOnPlanet>();
		
		body = new FlxSprite();
		centerOrigin();
		trace("body", body);
		origin.x = 8;
		origin.y = 8;
		add(body);
		
		nameLabel = new FlxText( -50, 20, 100, name, 12);
		nameLabel.alignment = 'center';
		add(nameLabel);
		
		infLabel = new FlxText( -50, 50, 100, "");
		infLabel .alignment = 'center';
		add(infLabel);
		
		market = new Market(this);
	}
	
	//	merchs appear and disappear, prices change
	public function work()
	{
		//trace(name, "work");
		for (i in 0...merchs.length)
		{
			if (FlxRandom.chanceRoll(50))
			{
				var availShift = Math.ceil(merchs[i].availability / 10);
				merchs[i].quantity += FlxRandom.intRanged( -availShift, availShift);
				if (availShift < 0)
				{
					merchs[i].currentPrice *= FlxRandom.floatRanged(1, 1.125);
				}
				else if (availShift > 0)
				{
					merchs[i].currentPrice *= FlxRandom.floatRanged(0.875, 1);
				}
			}
		}
		updateInfo();
		
	}
	
	public function addMerch(merch:MerchOnPlanet)
	{
		trace("addMerc");
		merchs.push(merch);
		market.addMerch(merch);
		updateInfo();
	}
	
	private function updateInfo()
	{
		trace("updateInfo");
		infLabel.text = "";
		for (i in 0...merchs.length)
		{
			//trace(i);
			infLabel.text += merchs[i].toString() + "\n";
		}
		market.updateLabels();
	}
	
}