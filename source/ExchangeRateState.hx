package ;

import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author damrem
 */
class ExchangeRateState extends FlxState
{
	var planet:Planet;
	var plot:flixel.group.FlxSpriteGroup;
	var currentX:Float;
	

	override public function create()
	{
		super.create();
		
		
		planet = new Planet("name", 0, 0);
		Merch.refPrices['Food'] = 100;
		var merch = new MerchOnPlanet("Food", 10);
		planet.addMerchType(merch);
		
		currentX = 0;
		plot = new FlxSpriteGroup(0, 200);
		add(plot);
		
		plot.add(new FlxShapeBox(0, -merch.refPrice, 640, 1, 
		{ thickness:0, color:0xffffff, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, 
		{ hasFill:true, color:0xff00ff00 } ));
		
		plot.add(new FlxShapeBox(0, 0, 640, 1, 
		{ thickness:0, color:0xffffff, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, 
		{ hasFill:true, color:0xffff0000 } ));
	}
	
	override public function update()
	{
		trace("update");
		super.update();
		
		for (key in planet.merchsByName.keys())
		{
			var merch:MerchOnPlanet=planet.merchsByName[key];
			plot.add(dot(currentX, -merch.currentPrice, 0xffff00));
			plot.add(dot(currentX, -merch.quantity, 0x0000ff));
		}	
		
		currentX += 0.25;
		planet.work();
	}
	
	function dot(X:Float, Y:Float, rgb:UInt=0xffffff):FlxSprite
	{
		trace("dot(" + X, Y);
		return new FlxShapeBox(X, Y, 1, 1, 
		{ thickness:0, color:rgb, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, 
		{ hasFill:true, color:0xff000000+rgb } );
	}
	
}