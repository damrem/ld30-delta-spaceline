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
	var trader:Trader;
	public var quantity:Int;
	
	public function new(Name:String, Avalaibility:UInt, _trader:Trader)
	{
		super(Name);
		
		trader = _trader;
		
		add(new FlxShapeBox(0, 0, 120, 50, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
		
		currentPrice = refPrice * FlxRandom.floatRanged(0.75, 1.25);
		availability = Avalaibility;
		quantity = Std.int(availability * FlxRandom.floatRanged(0.75, 1.25));
		
		nameLabel = new FlxText(30, 15, 120, name);
		nameLabel.color = 0x000000;
		add(nameLabel);
		
		priceLabel = new FlxText(57, 20, 50, "");
		priceLabel.alignment = 'right';
		priceLabel.color = 0x000000;
		add(priceLabel);
		
		var coin = new FlxSprite(106, 22);
		coin.loadGraphic("assets/images/minicoin.gif");
		add(coin);
		
		buyButton = new FlxSpriteGroup(85, 35);
		buyButton.add(new FlxShapeBox(-5, 0, 40, 15, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
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
		
		add(icon);
		icon.x = 10;
		icon.y = 10;
		//buyButton.width = 25;
	}
	
	function buy(?button:FlxSpriteGroup) 
	{
		trace("buy");
		if (quantity > 0)
		{
			quantity --;
			trader.fromMarketToInventory(this);
		}
	}
	
	override public function toString():String
	{
		return name + " x" + quantity + "\t¤" + Std.int(currentPrice);
	}
	
	public function updateText()
	{
		//trace("updateText");
		priceLabel.text = ""+Std.int(currentPrice);
	}
}