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
	
	public function new(Place:Planet) 
	{
		super();
		
		place = Place;
		
		var line:LineStyle = { thickness:1 };
		var fill:FillStyle = { hasFill:true, color:0x80ffffff };
		var bg:FlxShapeBox = new FlxShapeBox(0, 0, 150, 400, line, fill);
		add(bg);
		
		var nameLabel:FlxText = new FlxText(0, 0, 150, place.name, 12);
		add(nameLabel);
	}
	
	public function addMerch(merch:MerchOnPlanet)
	{
		trace("addMerch");
		merch.label.color = 0x000000;
		add(merch.label);
		updateLabels();
	}
	
	public function updateLabels()
	{
		trace("updateLabels");
		var currentY = 30;
		trace(place.merchs.length);
		for (i in 0...place.merchs.length)
		{
			var merch:MerchOnPlanet = place.merchs[i];
			merch.label.y = currentY;
			currentY += 30;
			merch.updateText();
		}
	}
}