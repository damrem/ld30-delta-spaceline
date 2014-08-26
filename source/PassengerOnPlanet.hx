package;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.util.FlxRandom;

/**
 * ...
 * @author damrem
 */
class PassengerOnPlanet extends Passenger 
{
	var takeButton:FlxSpriteGroup;
	var priceLabel:FlxText;
	
	
	public function new(From:Planet, To:Planet) 
	{
		super(From, To);
		
		var bg = new FlxShapeBox(0, 0, 120, 30, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff } );
		add(bg);
		
		var avatar = new FlxSprite(5, 14);
		avatar.loadGraphic("assets/images/passenger.gif");
		add(avatar);
		
		var toLabel = new FlxText(25, 2, 75, to.name);
		toLabel.color = 0x000000;
		add(toLabel);
		
		priceLabel = new FlxText(11, 15, 50, "" + getFare());
		priceLabel.alignment = 'right';
		priceLabel.color = 0x000000;
		add(priceLabel);
		
		var coin = new FlxSprite(60, 17);
		coin.loadGraphic("assets/images/minicoin.gif");
		add(coin);
		
		takeButton = new FlxSpriteGroup(80, 15);
		var buttonBg = new FlxShapeBox( -5, 0, 45, 15, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff } );
		takeButton.add(buttonBg);
		
		var arrow = new FlxSprite();
		arrow.y = 3;
		arrow.loadGraphic("assets/images/buy.gif");
		takeButton.add(arrow);
		
		var buyLabel = new FlxText(10, 0, 30, "Take");
		buyLabel.color = 0x000000;
		takeButton.add(buyLabel);
		
		MouseEventManager.add(bg);
		MouseEventManager.setMouseUpCallback(bg, take);
		
		add(takeButton);
		
		
	}
	
	function take(button:FlxSprite)
	{
		trace("take");
		var passenger = new PassengerInInventory(from, to);
		if (Inventory.single.takePassenger(passenger))
		{
			Inventory.single.addCredits(this.getFare());
			Market.single.removePassenger(this);
			Market.single.updatePassengers();
		}
		//Market.single.updatePassengers();
	}
	
	
	
}