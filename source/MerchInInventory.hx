package;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

/**
 * ...
 * @author damrem
 */
class MerchInInventory 
{
	var inUniv:MerchInUniv;
	var quantity:UInt;
	public var label:FlxText;
	public var sellButton:FlxButton;
	
	public function new(InUniv:MerchInUniv, Quantity:UInt=0) 
	{
		inUniv = InUniv;
		quantity = Quantity;
		
		label = new FlxText(0, 0, 150, "");
		label.alignment = 'center';
		
		sellButton = new FlxButton(30, 0, "Sell");
		sellButton.width = 25;
	}
	
	public function toString():String
	{
		return inUniv.name + " x" + quantity;
	}
	
	public function updateText()
	{
		//trace("updateText");
		label.text = this.toString();
	}
}