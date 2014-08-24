package ;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flixel.addons.display.shapes.FlxShapeCircle;
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
	var selector:FlxShapeCircle;
	var infLabel:FlxText;
	public var market:Market;
	
	var colors:Array<UInt> = [0xffff0000, 0xff00ff00, 0xff0000ff, 0xffffff00, 0xffff00ff, 0xff00ffff];
	
	public function new(Name:String, X:Int, Y:Int, trader:Trader) 
	{
		super(X, Y, 10);
		
		name = Name;
		
		MouseEventManager.add(this);
		
		merchs = new Array<MerchOnPlanet>();
		
		var radius:UInt = FlxRandom.intRanged(8, 24);
		var color:UInt = 0xff000000 + FlxRandom.intRanged(0x000000, 0xffffff);// colors[FlxRandom.intRanged(0, colors.length - 1)];
		body = new FlxShapeCircle( -radius, -radius, radius, { thickness:0, color:color }, { hasFill:true, color:color } );
		centerOrigin();
		add(body);
		//trace("body", body);
		//origin.x = 8;
		//origin.y = 8;
		
		//var selector:FlxShapeCircle = new FlxShapeCircle( -radius - 10, -radius - 10, radius + 20, 
		//{ thickness:5, color:0xffffff, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, { hasFill:true, color:0xffff8000 } );
//		var XY = - radius;
		//selector = new FlxShapeCircle( -radius, -radius, radius+10, { thickness:5, color:0xffffffff }, { hasFill:true, color:0xffff8000 } );
		//add(selector);
		
		nameLabel = new FlxText( -50, radius, 100, name);
		nameLabel.alignment = 'center';
		nameLabel.alpha = 0.25;
		add(nameLabel);
		
		infLabel = new FlxText( -50, 50, 100, "");
		infLabel .alignment = 'center';
		//add(infLabel);
		
		market = new Market(this, trader);
		market.x = market.y = 10;
	}
	
	//	merchs appear and disappear, prices change
	public function work()
	{
		//trace(name, "work");
		for (i in 0...merchs.length)
		{
			if (FlxRandom.chanceRoll(1))
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
	
	public function addMerchType(merch:MerchOnPlanet)
	{
		//trace("addMerc");
		merchs.push(merch);
		market.addMerchType(merch);
		updateInfo();
	}
	
	private function updateInfo()
	{
		//trace("updateInfo");
		infLabel.text = "";
		for (i in 0...merchs.length)
		{
			//trace(i);
			infLabel.text += merchs[i].toString() + "\n";
		}
		market.updateMerchs();
	}
	
}