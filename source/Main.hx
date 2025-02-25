package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
#if typebuild
import plugins.ExamplePlugin;
import plugins.ExamplePlugin.ExampleCharPlugin;
#end
class Main extends Sprite
{
	public static var ammo:Array<Int> = [4, 6, 7, 9];
	public static var curMusicName:String = "";
public static var baseTrace = haxe.Log.trace;
	
	#if sys
	public static var cwd:String;
	#end
	public function new()
	{
		#if typebuild
			// god is dead
			ExamplePlugin;
			ExampleCharPlugin;
		#end
		super();
		#if sys
		cwd = Sys.getCwd();
		#end
		addChild(new FlxGame(0, 0, TitleState, 1, OptionsHandler.options.fpsCap, OptionsHandler.options.fpsCap, true));
		#if !mobile
		addChild(new FPS(10, 3, 0xFFFFFF));
		#end
	}
}
