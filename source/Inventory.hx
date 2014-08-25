package;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil.FillStyle;
import flixel.util.FlxSpriteUtil.LineStyle;

/**
 * ...
 * @author damrem
 */
class Inventory extends FlxSpriteGroup
{
	var credits:UInt = 5000;
	var creditLabel:FlxText;
	//var fuel:Float;
	//var fuelLabel:FlxText;
	var ship:Ship;
	var size:Int = 6;
	var stock:Array<MerchInInventory>;
	var merchList:FlxSpriteGroup;
	var emptySlots:flixel.group.FlxSpriteGroup;
	static var _single:Inventory;
	
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
		
		stock = new Array<MerchInInventory>();
		
		var line:LineStyle = { thickness:1 };
		var fill:FillStyle = { hasFill:true, color:0x80ffffff, alpha:0.5 };
		var bg:FlxShapeBox = new FlxShapeBox(0, 0, 130, 460, line, fill);
		add(bg);
		
		var nameLabel = new FlxText(0, 10, 130, "Delta Spaceline", 12);
		nameLabel.alignment = 'center';
		add(nameLabel);
		
		var coin = new FlxSprite(10, 40);
		coin.loadGraphic("assets/images/coin.gif");
		add(coin);
		
		creditLabel = new FlxText(28, 40, 75, "", 12);
		creditLabel.color = 0x000000;
		add(creditLabel);
		updateCredit();
		
		//fuelLabel = new FlxText(10, 60, 130, "", 12);
		//fuelLabel.color = 0x000000;
		//add(fuelLabel);
		
		emptySlots = new FlxSpriteGroup(0, 75);
		for (i in 0...size)
		{
			var X = i % 2 * 70;
			var Y = Math.floor(i / 2) * 70;
			emptySlots.add(new FlxShapeBox(X, Y, 60, 60, { thickness:5, color:0xff0000, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, { hasFill:true, color:0x40ffffff }));
		}
		add(emptySlots);
		
		merchList = new FlxSpriteGroup(0, 75);
		add(merchList);
		
		
	}
	
	public function buyMerch(name:String, price:Float)
	{
		//trace("buyMerch");
		if (price <= credits && stock.length < size)
		{
			credits -= Std.int(price);
			updateCredit();
			
			stock.push(new MerchInInventory(name));
			
			updateMerchs();
			
			return true;
		}
		return false;
	}
	
	
	
	public function addCredits(Credits:UInt)
	{
		credits += Credits;
		updateCredit();
	}
	
	function updateCredit()
	{
		creditLabel.text = "" + credits;
	}
	/*
	public function updateFuel()
	{
		//trace(fuelLabel, ship);
		fuelLabel.text = "StarFuel x" + ship.fuel;
	}
	*/
	
	public function updateMerchs()
	{
		//trace("updateMerchs");
		
		merchList.clear();
		
		for (i in 0...stock.length)
		{
			var merch:MerchInInventory = stock[i];
			
			merch.x = i % 2 * 70;
			merch.y = Math.floor(i/2)*70;
			
			//merch.sellButton.y = currentY;
			//currentY += 35;
			merchList.add(merch);
			//merchList.add(merch.sellButton);
		}
	}
	
	public function removeMerch(name:String)
	{
		//trace("removeMerch");
		for (i in 0...stock.length)
		{
			if (stock[i].name == name)
			{
				merchList.remove(stock[i]);
				stock[i].destroy();
				stock.splice(i, 1);
				updateMerchs();
				return;
			}
		}
	}
	
	static function get_single():Inventory 
	{
		return _single;
	}
	
	static public var single(get_single, null):Inventory;
}