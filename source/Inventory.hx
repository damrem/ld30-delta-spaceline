package;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil.FillStyle;
import flixel.util.FlxSpriteUtil.LineStyle;

/**
 * ...
 * @author damrem
 */
class Inventory extends FlxSpriteGroup
{
	var nbTravels:UInt;
	public var nbCredits:UInt = 2500;
	var creditLabel:FlxText;
	//var fuel:Float;
	//var fuelLabel:FlxText;
	var ship:Ship;
	var size:Int = 6;
	//var merchs:Array<MerchInInventory>;
	var slots:FlxSpriteGroup;
	var emptySlots:FlxSpriteGroup;
	static var _single:Inventory;
	var travelLabel:FlxText;
	//var passengers:Array<Passenger>;
	
	public function new(_ship:Ship) 
	{
		if (_single == null)	_single = this;
		else 
		{
			return;
		}
		//trace("new(" + _ship);
		super();
		
		ship = _ship;
		
		//merchs = new Array<MerchInInventory>();
		//passengers = new Array<Passenger>();
		
		var line:LineStyle = { thickness:1 };
		var fill:FillStyle = { hasFill:true, color:0x80ffffff, alpha:0.5 };
		var bg:FlxShapeBox = new FlxShapeBox(0, 0, 130, 460, line, fill);
		add(bg);
		
		var nameLabel = new FlxText(0, 10, 130, "Delta Spaceline Ship Cargo", 12);
		nameLabel.alignment = 'center';
		add(nameLabel);
		
		var coin = new FlxSprite(10, 50);
		coin.loadGraphic("assets/images/coin.gif");
		add(coin);
		
		creditLabel = new FlxText(28, 50, 75, "", 12);
		creditLabel.color = 0x000000;
		add(creditLabel);
		updateCredit();
		
		var travel = new FlxSprite(10, 72);
		travel.loadGraphic("assets/images/travel.gif");
		add(travel);
		
		travelLabel = new FlxText(28, 70, 75, "", 12);
		travelLabel.color = 0x000000;
		add(travelLabel);
		updateTravels();
		
		//fuelLabel = new FlxText(10, 60, 130, "", 12);
		//fuelLabel.color = 0x000000;
		//add(fuelLabel);
		
		emptySlots = new FlxSpriteGroup(0, 100);
		for (i in 0...size)
		{
			var X = i % 2 * 70;
			var Y = Math.floor(i / 2) * 70;
			emptySlots.add(new FlxShapeBox(X, Y, 60, 60, { thickness:5, color:0xff0000, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, { hasFill:true, color:0x40ffffff }));
		}
		add(emptySlots);
		
		slots = new FlxSpriteGroup(emptySlots.x, emptySlots.y);
		add(slots);
	}
	
	function updateTravels() 
	{
		travelLabel.text = "" + nbTravels;
	}
	
	function isFull()
	{
		//trace(emptySlots.members.length+" - "+slots.members.length);
		return emptySlots.members.length - slots.members.length == 0;
	}
	
	function isEmpty()
	{
		return slots.members.length == 0;
	}
	
	public function buyMerch(name:String, price:Float):Bool
	{
		//trace("buyMerch");
		if (price <= nbCredits && !isFull())
		{
			nbCredits -= Std.int(price);
			updateCredit();
			
			slots.add(new MerchInInventory(name));
			//merchs.push();
			
			updateSlots();
			
			return true;
		}
		return false;
	}
	
	public function takePassenger(passenger:PassengerInInventory):Bool
	{
		//trace("takePassenger");
		if (!isFull())
		{
			//trace("still slots");
			slots.add(passenger);
			
			updateSlots();
			
			return true;
		}
		return false;
	}
	
	public function removePassenger(to:Planet)
	{
		//trace("removePassenger");
		//for (var i:UInt = 0; i < slots.members.length; i++ )
		var i:Int = 0;
		while(i < slots.members.length)
		{
			var item:Item = cast(slots.members[i]);
			//trace("slots.members[i]", slots.members[i]);
			//trace("item", item);
			if (item.name == 'passenger')
			{
				var passenger:Passenger = cast(item);
				if (passenger.to == to)
				{
					slots.remove(passenger, true);
					i--;
					passenger.destroy();
				}
			}
			i++;
		}
		updateSlots();
	}
	
	
	
	
	
	public function addCredits(earning:UInt)
	{
		nbCredits += earning;
		updateCredit();
		if (nbCredits >= 10000)
		{
			//var victory = new VictoryState(nbTravels);
			FlxG.switchState(new VictoryState(nbTravels));
		}
		
		if (isGameOver())
		{
			FlxG.switchState(new GameOverState(nbTravels));
		}
	}
	
	function isGameOver():Bool
	{
		//trace(isEmpty(), !canBuyMerch(), !canTravel());
		return isEmpty() && !canBuyMerch() && !canTravel();
	}
	
	function canBuyMerch():Bool
	{
		var canBuy:Bool=false;
		for (i in 0...Market.single.merchList.members.length)
		{
			var merch:MerchOnPlanet = cast(Market.single.merchList.members[i]);
			canBuy = canBuy || merch.currentPrice < nbCredits;
		}
		return canBuy;
	}
	
	function canTravel():Bool
	{
		var canTravel:Bool=false;
		for (i in 0...PlayState.planets.members.length)
		{
			var planet = PlayState.planets.members[i];
			canTravel = canTravel || FlxMath.distanceBetween(planet, PlayState.currentPlanet) / 2 < nbCredits;
		}
		return canTravel;
	}
	
	function updateCredit()
	{
		creditLabel.text = "" + nbCredits;
	}
	/*
	public function updateFuel()
	{
		//trace(fuelLabel, ship);
		fuelLabel.text = "StarFuel x" + ship.fuel;
	}
	*/
	
	function updateSlots()
	{
		//trace("updateSlots");
		
		//slots.clear();
		
		for (i in 0...slots.members.length)
		{
			var item:Item = cast(slots.members[i]);
			//trace(item.name);
			
			item.x = i % 2 * 70;
			item.y = Math.floor(i/2)*70;
			
			//merch.sellButton.y = currentY;
			//currentY += 35;
			slots.add(item);
			//merchList.add(merch.sellButton);
		}
	}
	
	public function removeMerch(name:String)
	{
		//trace("removeMerch");
		for (i in 0...slots.members.length)
		{
			var merch:Item = cast(slots.members[i]);
			if (merch.name == name)
			{
				slots.remove(merch, true);
				merch.destroy();
				updateSlots();
				return;
			}
		}
	}
	
	public function addTravels() 
	{
		nbTravels++;
		updateTravels();
	}
	
	static function get_single():Inventory 
	{
		return _single;
	}
	
	static public var single(get_single, null):Inventory;
}