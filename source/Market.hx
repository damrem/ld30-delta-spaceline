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
	public var merchList:FlxSpriteGroup;
	var passengerList:FlxSpriteGroup;
	
	public function new() 
	{
		//trace("new");
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
		
		merchList = new FlxSpriteGroup(10, 80);
		//merchList.alpha = 0.5;
		add(merchList);
		
		passengerList = new FlxSpriteGroup(10, 210);
		add(passengerList);
	}
	
	public function setPlanet(_planet:Planet)
	{
		//if (planet == null)	return;
		if(planet!=null)	planet.onUpdateInfo.removeAll();
		//trace("setPlanet");
		planet = _planet;
		planet.onUpdateInfo.add(updateMerchs);
		planet.onUpdateInfo.add(updatePassengers);
		//trace(planet, nameLabel);
		nameLabel.text = "Planet " + planet.name.toUpperCase();
		
		updateMerchs();
		updatePassengers();
	}
	
	public function updatePassengers() 
	{
		//if(planet == PlayState.currentPlanet)	trace("updatePassengers");
		passengerList.clear();
		passengerList.x = 10;
		
		for (i in 0...planet.passengers.length)
		{
			var passenger:PassengerOnPlanet = planet.passengers[i];
			passenger.x = 0;
			passenger.y = i * 35;
			passengerList.add(passenger);
			//passengers.add(passenger);
		}
	}
	
	public function removePassenger(passenger)
	{
		var i:Int = 0;
		//for (i in 0...planet.passengers.length)
		while (i < planet.passengers.length)
		{
			if (planet.passengers[i] == passenger)
			{
				//trace("before", planet.passengers.length);
				passengerList.remove(passenger);
				passenger.destroy();
				planet.passengers.splice(i, 1);
				i--;
				//trace("after", planet.passengers.length);
				return;
			}
			i++;
		}
	}
	
	
	
	public function updateMerchs()
	{
		//trace("updateMerchs");
		var currentY = 65;
		merchList.clear();
		merchList.y = 80;
		merchList.x = 10;
		//trace(place.merchs.length);
		for (key in planet.merchsByName.keys())
		{
			var merch:MerchOnPlanet = planet.merchsByName[key];
			merch.trader = trader;
			merchList.add(merch);
			merch.x = 10;
			merch.y = currentY;
			currentY += 35;
			merch.updateText();
		}
	}
	
	public function buyMerch(name:String) 
	{
		//trace("buyMerch");
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