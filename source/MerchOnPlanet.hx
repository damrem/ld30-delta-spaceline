package;

import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;
import MerchInUniv;

class MerchOnPlanet extends Merch
{
	public var currentPrice:Float;
	public var availability:Float;
	var nameLabel:FlxText;
	var priceLabel:FlxText;
	public var buyButton:FlxSpriteGroup;
	public var onBuy:Void->Void;
	var _trader:Trader;
	var trendIcon:FlxSprite;
	var trendHolder:FlxSpriteGroup;
	public var quantity:Int;
	public var trendTick:UInt=0;
	public var trend:Int;
	public var trendDuration:UInt;
	
	public function new(Name:String, Avalaibility:UInt)
	{
		super(Name);
		
		add(new FlxShapeBox(0, 0, 120, 50, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
		
		currentPrice = refPrice * FlxRandom.floatRanged(0.8, 1.25);
		availability = Avalaibility;
		quantity = Std.int(availability * FlxRandom.floatRanged(0.8, 1.25));
		//trace("quantity", quantity);
		
		nameLabel = new FlxText(30, 12, 120, "");
		nameLabel.color = 0x000000;
		add(nameLabel);
		
		trendHolder = new FlxSpriteGroup(30, 35);
		add(trendHolder);
		
		priceLabel = new FlxText(16, 35, 50, "");
		priceLabel.alignment = 'right';
		priceLabel.color = 0x000000;
		add(priceLabel);
		
		var coin = new FlxSprite(65, 37);
		coin.loadGraphic("assets/images/minicoin.gif");
		add(coin);
		
		buyButton = new FlxSpriteGroup(85, 35);
		var bg = new FlxShapeBox( -5, 0, 40, 15, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff } );
		buyButton.add(bg);
		var arrow = new FlxSprite();
		arrow.y = 3;
		arrow.loadGraphic("assets/images/buy.gif");
		buyButton.add(arrow);
		var buyLabel = new FlxText(10, 0, 30, "Buy");
		buyLabel.color = 0x000000;
		buyButton.add(buyLabel);
		MouseEventManager.add(buyButton);
		MouseEventManager.setMouseUpCallback(buyButton, buy);
		add(buyButton);
		
		var icon = getNewIcon();
		add(icon);
		icon.x = 10;
		icon.y = 10;
		//buyButton.width = 25;
	}
	
	function buy(button:FlxSpriteGroup) 
	{
		//trace("buy");
		//trace("quantity", quantity, name);
		if (quantity > 0)
		{
			//trace("quantity ok");
			//trace("trader", _trader);
			if (_trader.fromMarketToInventory(this))
			{
				//trace("space and credit ok");
				quantity --;
				updateText();
			}
		}
		
		//trace(PlayState.currentPlanet.name);
		
	}
	
	override public function toString():String
	{
		return name + " x" + quantity + "\t¤" + Std.int(currentPrice);
	}
	
	public function updateText()
	{
		//trace("updateText");
		nameLabel.text = name + " x" + quantity;
		priceLabel.text = "" + Std.int(currentPrice);
		if (quantity == 0)
		{
			alpha = 0.25;
		}
		else
		{
			alpha = 1.0;
		}
		trendHolder.remove(trendIcon);
		trendIcon = getTrendIcon();
		trendHolder.add(trendIcon);
	}
	
	public function getTrendIcon():FlxSprite
	{
		var trend = new FlxSprite();
		if (currentPrice > refPrice * 1.2)
		{
			trend.loadGraphic("assets/images/upup.gif");
		}
		else if (currentPrice > refPrice * 1.1)
		{
			trend.loadGraphic("assets/images/up.gif");
		}
		else if (currentPrice < refPrice * 0.9)
		{
			trend.loadGraphic("assets/images/dn.gif");
		}
		else if (currentPrice < refPrice * 0.8)
		{
			trend.loadGraphic("assets/images/dndn.gif");
		}
		else
		{
			trend.loadGraphic("assets/images/eq.gif");
		}
		return trend;
	}
	
	private function set_trader(value:Trader):Trader 
	{
		return _trader = value;
	}
	
	public var trader(null, set_trader):Trader;
}