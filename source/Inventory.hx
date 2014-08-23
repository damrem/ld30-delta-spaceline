package;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil.FillStyle;
import flixel.util.FlxSpriteUtil.LineStyle;

/**
 * ...
 * @author damrem
 */
class Inventory extends FlxSpriteGroup
{
	var merchs:Array<MerchInInventory>;
	var credits:UInt = 10000;
	var creditLabel:FlxText;
	var fuel:Float;
	var fuelLabel:FlxText;
	var ship:Ship;
	
	public function new(_ship:Ship) 
	{
		trace("new(" + _ship);
		super();
		
		ship = _ship;
		
		merchs = new Array<MerchInInventory>();
		
		var line:LineStyle = { thickness:1 };
		var fill:FillStyle = { hasFill:true, color:0x80ffffff, alpha:0.5 };
		var bg:FlxShapeBox = new FlxShapeBox(0, 0, 150, 400, line, fill);
		add(bg);
		
		var nameLabel:FlxText = new FlxText(0, 0, 150, "Delta Spaceline", 12);
		add(nameLabel);
		
		creditLabel = new FlxText(0, 30, 150, "");
		creditLabel.color = 0x000000;
		add(creditLabel);
		updateCredit();
		
		fuelLabel = new FlxText(0, 50, 150, "");
		fuelLabel.color = 0x000000;
		add(fuelLabel);
	}
	
	public function addMerchType(merch:MerchInInventory)
	{
		trace("addMerch(" + merch);
		merchs.push(merch);
		merch.label.color = 0x000000;
		add(merch.label);
		add(merch.sellButton);
		updateMerchs();
	}
	
	public function setCredits(Credits:UInt)
	{
		credits = Credits;
		updateCredit;
	}
	
	function updateCredit()
	{
		creditLabel.text = "¤" + credits;
	}
	
	public function updateFuel()
	{
		trace(fuelLabel, ship);
		fuelLabel.text = "Fuel x" + ship.fuel;
	}
	
	public function updateMerchs()
	{
		var currentY = 60;
		for (i in 0...merchs.length)
		{
			var merch:MerchInInventory = merchs[i];
			merch.label.y = merch.sellButton.y = currentY;
			currentY += 30;
			merch.updateText();
		}
	}
}