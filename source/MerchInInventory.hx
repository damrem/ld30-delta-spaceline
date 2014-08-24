package;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * ...
 * @author damrem
 */
class MerchInInventory extends Merch
{
	public var label:FlxText;
	public var sellButton:FlxButton;
	var trader:Trader;
	
	public function new(Name:String, Quantity:UInt=0, _trader:Trader) 
	{
		super(Name, Quantity);
		
		trader = _trader;
		
		label = new FlxText(0, 0, 150, "");
		label.alignment = 'center';
		
		sellButton = new FlxButton(30, 0, "Sell", sell);
		sellButton.width = 25;
	}
	
	function sell() 
	{
		trace("sell");
		if (quantity > 0)
		{
			quantity--;
			updateText();
			trader.fromInventoryToMarket(this);
		}
	}
	
	public function toString():String
	{
		return name + " x" + quantity;
	}
	
	public function updateText()
	{
		//trace("updateText");
		label.text = this.toString();
	}
}