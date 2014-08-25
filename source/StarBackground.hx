package ;
import flash.display.CapsStyle;
import flash.display.JointStyle;
import flash.display.LineScaleMode;
import flixel.addons.display.shapes.FlxShapeBox;
import flixel.addons.display.shapes.FlxShapeCross;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxRandom;

/**
 * ...
 * @author damrem
 */
class StarBackground extends FlxSpriteGroup
{

	public function new() 
	{
		super();
		add(new FlxShapeBox(0, 0, 640, 480, 
		{ thickness:0, color:0x000000, scaleMode:LineScaleMode.NORMAL, jointStyle:JointStyle.BEVEL, capsStyle:CapsStyle.NONE }, 
		{ hasFill:true, color:0xff000000 } ));

		for (i in 0...100)
		{
			var starlength:UInt = FlxRandom.intRanged(1, 5);
			var starsize:UInt = FlxRandom.intRanged(0, 1);
			var star:FlxShapeCross = new FlxShapeCross(FlxRandom.intRanged(0, 640), FlxRandom.intRanged(0, 480),
			starlength, starsize, starlength, starsize, 0.5, 0.5, 
			{ thickness: 0, color:0x00000000 }, { hasFill:true, color:0xffffffff } );
			star.alpha = FlxRandom.intRanged(0, 1);
			add(star);
		}
	}
	
}