package;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import MerchInUniv;
class MerchOnPlanet
{
	public var inUniv:MerchInUniv;
	public var quantity:UInt;
	public var currentPrice:Float;
	public var availability:Float;
	public var label:FlxText;
	
	public function new(InUniv:MerchInUniv, Avalaibility:UInt)
	{
		inUniv = InUniv;
		currentPrice = inUniv.refPrice * FlxRandom.floatRanged(0.75, 1.25);
		availability = Avalaibility;
		quantity = Std.int(availability * FlxRandom.floatRanged(0.75, 1.25));
		
		label = new FlxText(0, 0, 150, "empty");
	}
	
	public function toString():String
	{
		return inUniv.name + " x" + quantity + "\n¤" + Std.int(currentPrice) +"\n";
	}
	
	public function updateText()
	{
		trace("updateText");
		label.text = this.toString();
	}
}