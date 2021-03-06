package ;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flash.display.Sprite;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeCircle;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import flixel.util.FlxSignal;
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
	public var onUpdateInfo:FlxSignal;
	
	var colors:Array<UInt> = [0xffff0000, 0xff00ff00, 0xff0000ff, 0xffffff00, 0xffff00ff, 0xff00ffff];
	public var info:FlxSpriteGroup;
	
	public var passengers:Array<PassengerOnPlanet>;
	
	public function new(Name:String, X:Int, Y:Int) 
	{
		super(X, Y, 10);
		
		name = Name;
		
		MouseEventManager.add(this);
		
		onUpdateInfo = new FlxSignal();
		
		merchsByName = new Map<String, MerchOnPlanet>();
		
		passengers = new Array<PassengerOnPlanet>();
		
		var radius:UInt = FlxRandom.intRanged(8, 32);
		var color:UInt = 0xff000000 + FlxRandom.intRanged(0x000000, 0xffffff);// colors[FlxRandom.intRanged(0, colors.length - 1)];
		add(new FlxShapeCircle( -radius, -radius, radius, { thickness:0, color:0xff000000 }, { hasFill:true, color:0xff000000 } ));
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
		
		//add(info);
		
		/*
		infLabel = new FlxText( -50, 50, 100, "");
		infLabel .alignment = 'center';
		add(infLabel);
		*/
		hideInfo();
		
		
	}
	
	public function hideInfo(?planet:Planet) 
	{
		info.visible = false;
		if(PlayState.currentPlanet!=this)	downlight();
		//infLabel.visible = false;
	}
	
	public function showInfo(?planet:Planet) 
	{
		info.visible = true;
		if(PlayState.currentPlanet!=this)	highlight(0.5);
		//infLabel.visible = true;
	}
	
	//	merchs appear and disappear, prices change
	public function work()
	{
		//trace(name, "work");
		for (key in merchsByName.keys())
		{
			//if (FlxRandom.chanceRoll(100))
			{
				var merch:MerchOnPlanet = merchsByName[key];
				
				merch.quantity += FlxRandom.intRanged( -1, 1);
				if (merch.quantity < 0)	merch.quantity = 0;
				
				merch.currentPrice += FlxRandom.floatRanged( -5.0, 5.0);
				if (merch.currentPrice < 0)	merch.currentPrice = merch.refPrice;
				
			}
		}
		updateInfo();
		
		passengers.splice(0, passengers.length);
		
		var nbPassengers = FlxRandom.intRanged(0, 3);
		
		for (i in 0...nbPassengers)
		{
			var from:Planet;
			do
			{
				from = cast(PlayState.planets.getRandom());
			}
			while (from == this);
			//trace("before", passengers.length);
			passengers.push(new PassengerOnPlanet(this, from));
		}
		Market.single.updatePassengers();
		
	}
	
	public function addMerchType(merch:MerchOnPlanet)
	{
		//trace("addMerc");
		merchsByName[merch.name] = merch;
		updateInfo();
	}
	
	public function downlight() 
	{
		body.alpha = 0.125;
		
	}
	
	public function highlight(intensity = 1.0) 
	{
		body.alpha = intensity;
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
			//trace(info);
			
			//trace("icon", icon);
			//trace("info", info);
			//info.add(new FlxText(10, currentY, 80, merch.icon));
			currentY += 20;
			
			onUpdateInfo.dispatch();
		}
		
		
	}
	
	override public function update()
	{
		super.update();
		
		if (info.visible)
		{
			info.setPosition(FlxG.mouse.x, FlxG.mouse.y);
		}
	}
	
	
	
}