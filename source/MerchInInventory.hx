package;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.plugin.MouseEventManager;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxRandom;

/**
 * ...
 * @author damrem
 */
class MerchInInventory extends Merch
{
	public var label:FlxText;
	public var sellButton:FlxSpriteGroup;
	
	public function new(Name:String) 
	{
		super(Name);
		
		add(new FlxShapeBox(0, 0, 60, 60, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
		
		label = new FlxText(0, 0, 60, "", 10);
		label.color = 0x000000;
		label.alignment = 'center';
		label.text = Name;
		add(label);
		
		//sellButton = new FlxButton(0, 20, "Sell", sell);
		sellButton = new FlxSpriteGroup(15, 45);
		sellButton.add(new FlxShapeBox(-5, 0, 40, 15, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
		var arrow = new FlxSprite();
		arrow.y = 3;
		arrow.loadGraphic("assets/images/sell.gif");
		sellButton.add(arrow);
		var sellLabel = new FlxText(10, 0, 30, "Sell");
		sellLabel.color = 0x000000;
		sellButton.add(sellLabel);
		MouseEventManager.add(sellButton);
		MouseEventManager.setMouseUpCallback(sellButton, sell);
		add(sellButton);
		
		var icon = getNewIcon();
		add(icon);
		icon.x = icon.y = 22;
	}
	
	function sell(?button:FlxSpriteGroup) 
	{
		//trace("sell");
		PlayState.market.trader.fromInventoryToMarket(this);
	}
}