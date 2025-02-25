package;

import flixel.system.FlxAssets.FlxShader;
import openfl.display.Shader;
import openfl.display.ShaderInput;
import flixel.FlxSprite;
import hscript.Interp;
import hscript.ParserEx;
import hscript.InterpEx;
import flixel.FlxG;

class ShaderHandler extends FlxShader
{
	public function new(frag:String = '', vert:String = '')
	{
		
		if (frag != '')
			glFragmentSource = frag;

		if (vert != '')
			glVertexSource = vert;

		super();
	}
}

/*
class ShaderHandler
{
	// stuff
	var hscriptStates:Map<String, Interp> = [];
	var exInterp:InterpEx = new InterpEx();
	var haxeSprites:Map<String, FlxSprite> = [];
	var string;
	function callHscript(func_name:String, args:Array<Dynamic>, usehaxe:String) {
		// if function doesn't exist
		if (!hscriptStates.get(usehaxe).variables.exists(func_name)) {
			trace("Function doesn't exist, silently skipping...");
			return;
		}
		var method = hscriptStates.get(usehaxe).variables.get(func_name);
		switch(args.length) {
			case 0:
				method();
			case 1:
				method(args[0]);
			case 2:
				method(args[0], args[1]);
		}
	}
	function callAllHScript(func_name:String, args:Array<Dynamic>) {
		for (key in hscriptStates.keys()) {
			callHscript(func_name, args, key);
		}
	}
	function setHaxeVar(name:String, value:Dynamic, usehaxe:String) {
		hscriptStates.get(usehaxe).variables.set(name,value);
	}
	function getHaxeVar(name:String, usehaxe:String):Dynamic {
		return hscriptStates.get(usehaxe).variables.get(name);
	}
	function setAllHaxeVar(name:String, value:Dynamic) {
		for (key in hscriptStates.keys())
			setHaxeVar(name, value, key);
	}
	function makeHaxeState(usehaxe:String, path:String, filename:String) {
		trace("opening a haxe state (because we are cool :))");
		var parser = new ParserEx();
		var program = parser.parseString(FNFAssets.getHscript(path + filename));
		var interp = PluginManager.createSimpleInterp();
		// set vars
		interp.variables.set("FlxShader", FlxShader);
		interp.variables.set("update", function update(elapsed:Float) {} );
		interp.variables.set("new", function create() {} );
		interp.variables.set("setShader", setShader);
		// stuff
		trace("set stuff");
		interp.execute(program);
		hscriptStates.set(usehaxe,interp);
		trace('executed');
	}

	function setShader(shString:String) 
	{
		string = shString;
	}

	public function new(shader:String):Void
	{
		makeHaxeState("shader", "assets/shaders/" + shader + "/", "shader");
		callAllHScript("create", []);
	}

	public function update(elapsed:Float):Void
	{
		callAllHScript("update", [elapsed]);
	}
}
*/

