package ;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flixel.addons.display.shapes.FlxShapeBox;
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
	public var merchsByName:Map<String, MerchOnPlanet>;
	var body:FlxSpriteGroup;
	var selector:FlxShapeCircle;
	//var infLabel:FlxText;
	
	var colors:Array<UInt> = [0xffff0000, 0xff00ff00, 0xff0000ff, 0xffffff00, 0xffff00ff, 0xff00ffff];
	var info:flixel.group.FlxSpriteGroup;
	
	public function new(Name:String, X:Int, Y:Int) 
	{
		super(X, Y, 10);
		
		name = Name;
		
		MouseEventManager.add(this);
		
		merchsByName = new Map<String, MerchOnPlanet>();
		
		var radius:UInt = FlxRandom.intRanged(8, 24);
		var color:UInt = 0xff000000 + FlxRandom.intRanged(0x000000, 0xffffff);// colors[FlxRandom.intRanged(0, colors.length - 1)];
		body = new FlxSpriteGroup();
		body.add(new FlxShapeCircle( -radius, -radius, radius, { thickness:0, color:color }, { hasFill:true, color:color } ));
		centerOrigin();
		body.add(new FlxShapeCircle( Std.int( -radius * 0.875), Std.int( -radius * 0.875), Std.int(radius * 0.75), { thickness:0, color:0x40ffffff }, { hasFill:true, color:0x40ffffff } ));
		body.add(new FlxShapeCircle( Std.int(-radius*0.6875), Std.int(-radius*0.6875), Std.int(radius*0.5), { thickness:0, color:0x40ffffff }, { hasFill:true, color:0x40ffffff } ));
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
		//nameLabel.alpha = 0.25;
		add(nameLabel);
		
		info = new FlxSpriteGroup();
		
		add(info);
		
		/*
		infLabel = new FlxText( -50, 50, 100, "");
		infLabel .alignment = 'center';
		add(infLabel);
		*/
		hideInfo();
		
		MouseEventManager.setMouseOverCallback(this, showInfo);
		MouseEventManager.setMouseOutCallback(this, hideInfo);
	}
	
	function hideInfo(?planet:Planet) 
	{
		info.visible = false;
		if(PlayState.currentPlanet!=this)	downlight();
		//infLabel.visible = false;
	}
	
	function showInfo(?planet:Planet) 
	{
		info.visible = true;
		if(PlayState.currentPlanet!=this)	hightlight(0.5);
		//infLabel.visible = true;
	}
	
	//	merchs appear and disappear, prices change
	public function work()
	{
		//trace(name, "work");
		for (key in merchsByName.keys())
		{
			if (FlxRandom.chanceRoll(5))
			{
				var merch:MerchOnPlanet = merchsByName[key];
				var availShift = Math.ceil(merch.availability / 10);
				merch.quantity += FlxRandom.intRanged( -availShift, availShift);
				if (merch.quantity < 0)	merch.quantity = 0;
				if (availShift < 0)
				{
					merch.currentPrice *= FlxRandom.floatRanged(1, 1.125);
				}
				else if (availShift > 0)
				{
					merch.currentPrice *= FlxRandom.floatRanged(0.875, 1);
				}
				updateInfo();
			}
		}
		
	}
	
	public function addMerchType(merch:MerchOnPlanet)
	{
		//trace("addMerc");
		merchsByName[merch.name] = merch;
		updateInfo();
	}
	
	public function downlight() 
	{
		body.alpha = nameLabel.alpha = 0.25;
		
	}
	
	public function hightlight(intensity=1.0) 
	{
		body.alpha = nameLabel.alpha = intensity;
	}
	
	private function updateInfo()
	{
		//trace("updateInfo");
		//infLabel.text = "";
		/*
		for (key in merchsByName.keys())
		{
			//trace(i);
			
			infLabel.text += merchsByName[key].toString() + "\n";
		}
		*/
		var currentY = 10;
		info.clear();
		info.add(new FlxShapeBox(0, 0, 52, 94, 
		{ thickness:0, color:0xffffff, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, 
		{ hasFill:true, color:0x80ffffff } ));
		for (key in merchsByName.keys())
		{
			var merch:MerchOnPlanet = merchsByName[key];
			
			var icon = merch.getNewIcon();
			//icon.loadGraphic(
			
			icon.x = 10;
			icon.y = currentY;
			info.add(icon);
			
			var trend = merch.getTrendIcon();
			trend.x = 30;
			trend.y = currentY + 2;
			
			if (merch.quantity == 0)
			{
				icon.alpha = trend.alpha = 0.25;
			}
			
			//trace("trend", trend);
			info.add(trend);
			
			//trace("icon", icon);
			//trace("info", info);
			//info.add(new FlxText(10, currentY, 80, merch.icon));
			currentY += 20;
		}
	}
	
	
	
}