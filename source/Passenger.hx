package;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import flixel.util.FlxRandom;

/**
 * ...
 * @author damrem
 */
class Passenger extends FlxSpriteGroup 
{
	var takeButton:FlxSpriteGroup;
	var priceLabel:FlxText;
	public var from:Planet;
	public var to:Planet;
	
	public function new(From:Planet, To:Planet) 
	{
		super();
		from = From;
		to = To;
		
		add(new FlxShapeBox(0, 0, 120, 30, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
		
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
		var bg = new FlxShapeBox( -5, 0, 45, 15, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff } );
		takeButton.add(bg);
		
		var arrow = new FlxSprite();
		arrow.y = 3;
		arrow.loadGraphic("assets/images/buy.gif");
		takeButton.add(arrow);
		
		var buyLabel = new FlxText(10, 0, 30, "Take");
		buyLabel.color = 0x000000;
		takeButton.add(buyLabel);
		
		MouseEventManager.add(takeButton);
		MouseEventManager.setMouseUpCallback(takeButton, take);
		
		add(takeButton);
		
		
	}
	
	function take(button:FlxSpriteGroup)
	{
		trace("take");
	}
	
	function getFare():UInt
	{
		return FlxMath.distanceBetween(from, to);
	}
	
}