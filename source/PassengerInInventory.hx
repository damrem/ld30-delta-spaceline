package ;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.FlxSprite;
import flixel.text.FlxText;

/**
 * ...
 * @author damrem
 */
class PassengerInInventory extends Passenger
{

	public function new(From:Planet, To:Planet) 
	{
		super(From, To);
		
		add(new FlxShapeBox(0, 0, 60, 60, { thickness:0, color:0xffffff }, { hasFill:true, color:0x80ffffff }));
		
		var avatar = new FlxSprite(22, 18);
		avatar.loadGraphic("assets/images/passenger.gif");
		add(avatar);
		
		var toLabel = new FlxText(0, 33, 60, to.name);
		toLabel.alignment = 'center';
		toLabel.color = 0x000000;
		add(toLabel);
	}
	
}