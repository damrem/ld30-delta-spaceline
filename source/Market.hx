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
	var nameLabel:FlxText;
	public var planet:Planet;
	public var trader:Trader;
	static var _single:Market;
	var merchList:FlxSpriteGroup;
	
	public function new() 
	{
		if (_single == null)	_single = this;
		else 
		{
			return;
		}
		
		super();
		trader = new Trader();
		
		var line:LineStyle = { thickness:1 };
		var fill:FillStyle = { hasFill:true, color:0x80ffffff };
		var bg:FlxShapeBox = new FlxShapeBox(0, 0, 120, 460, line, fill);
		add(bg);
		
		nameLabel = new FlxText(10, 10, 100, "", 12);
		nameLabel.alignment = 'center';
		add(nameLabel);
		
		merchList = new FlxSpriteGroup(10, 60);
		add(merchList);
	}
	
	public function setPlanet(_planet:Planet)
	{
		trace("setPlanet");
		planet = _planet;
		trace(planet, nameLabel);
		nameLabel.text = planet.name;
		
		updateMerchs();
	}
	
	
	
	public function updateMerchs()
	{
		trace("updateMerchs");
		var currentY = 50;
		merchList.clear();
		merchList.x = 10;
		//trace(place.merchs.length);
		for (key in planet.merchsByName.keys())
		{
			var merch:MerchOnPlanet = planet.merchsByName[key];
			merch.trader = trader;
			merchList.add(merch);
			merch.x = 10;
			merch.y = currentY;
			currentY += 60;
			merch.updateText();
		}
	}
	
	public function buyMerch(name:String) 
	{
		trace("buyMerch");
		var merch:MerchOnPlanet = planet.merchsByName[name];
		//planet.alpha = 0.25;
		merch.quantity ++;
		merch.updateText();
	}
	
	static function get_single():Market 
	{
		return _single;
	}
	
	static public var single(get_single, null):Market;
}