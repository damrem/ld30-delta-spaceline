package;

import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import MerchInUniv;

class MerchOnPlanet extends Merch
{
	public var currentPrice:Float;
	public var availability:Float;
	public var label:FlxText;
	public var buyButton:FlxButton;
	public var onBuy:Void->Void;
	var trader:Trader;
	
	public function new(Name:String, Avalaibility:UInt, _trader:Trader)
	{
		super(Name);
		
		trader = _trader;
		
		currentPrice = refPrice * FlxRandom.floatRanged(0.75, 1.25);
		availability = Avalaibility;
		quantity = Std.int(availability * FlxRandom.floatRanged(0.75, 1.25));
		
		label = new FlxText(10, 0, 120, "");
		label.alignment = 'center';
		
		buyButton = new FlxButton(30, 0, "Buy", buy);
		//buyButton.width = 25;
	}
	
	function buy() 
	{
		if (quantity > 0)
		{
			quantity --;
			trader.fromMarketToInventory(this);
		}
	}
	
	public function toString():String
	{
		return name + " x" + quantity + "\n¤" + Std.int(currentPrice) +"\n";
	}
	
	public function updateText()
	{
		//trace("updateText");
		label.text = this.toString();
	}
}