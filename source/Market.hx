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
	var place:Planet;
	var trader:Trader;
	
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
		merch.label.color = 0x000000;
		add(merch.label);
		add(merch.buyButton);
		
		updateMerchs();
	}
	
	public function updateMerchs()
	{
		//trace("updateLabels");
		var currentY = 55;
		//trace(place.merchs.length);
		for (i in 0...place.merchs.length)
		{
			var merch:MerchOnPlanet = place.merchs[i];
			merch.label.y = currentY;
			currentY += 25;
			merch.buyButton.y = currentY;
			currentY += 35;
			merch.updateText();
		}
	}
}