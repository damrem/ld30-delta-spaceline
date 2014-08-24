package;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxRandom;

/**
 * ...
 * @author damrem
 */
class MerchInInventory extends Merch
{
	public var label:FlxText;
	public var sellButton:FlxButton;
	
	public function new(Name:String) 
	{
		super(Name);
		
		add(new FlxShapeBox(0, 0, 60, 60, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
		
		label = new FlxText(0, 0, 60, "");
		label.alignment = 'center';
		label.text = Name;
		add(label);
		
		sellButton = new FlxButton(0, 20, "Sell", sell);
		add(sellButton);
	}
	
	function sell() 
	{
		trace("sell");
		PlayState.currentMarket.trader.fromInventoryToMarket(this);
	}
}