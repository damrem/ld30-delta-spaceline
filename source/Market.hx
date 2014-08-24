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
class Market extends FlxSpriteGroup
{
	public var place:Planet;
	public var trader:Trader;
	
	public function new(Place:Planet, _trader:Trader) 
	{
		super();
		trader = _trader;
		
		place = Place;
		
		var line:LineStyle = { thickness:1 };
		var fill:FillStyle = { hasFill:true, color:0x80ffffff };
		var bg:FlxShapeBox = new FlxShapeBox(0, 0, 140, 460, line, fill);
		add(bg);
		
		var nameLabel:FlxText = new FlxText(10, 10, 120, place.name, 12);
		nameLabel.alignment = 'center';
		add(nameLabel);
	}
	
	public function addMerchType(merch:MerchOnPlanet)
	{
		//trace("addMerch");
		add(merch);
		
		updateMerchs();
	}
	
	public function updateMerchs()
	{
		//trace("updateLabels");
		var currentY = 55;
		//trace(place.merchs.length);
		for (key in place.merchs.keys())
		{
			var merch:MerchOnPlanet = place.merchs[key];
			merch.x = 20;
			merch.y = currentY;
			currentY += 60;
			//merch.buyButton.y = currentY;
			//currentY += 35;
			merch.updateText();
		}
	}
	
	public function buyMerch(name:String) 
	{
		var merch:MerchOnPlanet = place.merchs[name];
		merch.quantity ++;
		merch.updateText();
	}
}