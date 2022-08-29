package;

import Section.SwagSection;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import lime.utils.Assets;
import DifficultyIcons;
import lime.system.System;

import hscript.Interp;
import hscript.Parser;
import hscript.ParserEx;
import hscript.InterpEx;
#if sys
import flixel.system.FlxSound;
#end
using StringTools;

class CreditsState extends MusicBeatState
{
	var songs:Array<Array<String>> = [];

	var hscriptStates:Map<String, Interp> = [];
	var exInterp:InterpEx = new InterpEx();
	var haxeSprites:Map<String, FlxSprite> = [];

	#if debug
		var debugTarget = true;
	#else
		var debugTarget = false;
	#end

	#if switch
		var switchTarget = true;
	#else
		var switchTarget = false;
	#end

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
			case 3:
				method(args[0], args[1], args[2]);
			case 4:
				method(args[0], args[1], args[2], args[3]);
			case 5:
				method(args[0], args[1], args[2], args[3], args[4]);
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
		interp.variables.set("Sys", Sys);
		interp.variables.set("FlxTextBorderStyle", FlxTextBorderStyle);
		interp.variables.set("controls", controls);
		interp.variables.set("MainMenuState", MainMenuState);
		interp.variables.set("CategoryState", CategoryState);
		interp.variables.set("ChartingState", ChartingState);
		interp.variables.set("Alphabet", Alphabet);
		interp.variables.set("curBeat", 0);
		interp.variables.set("currentFreeplayState", this);
		interp.variables.set("add", add);
		interp.variables.set("remove", remove);
		interp.variables.set("insert", insert);
		interp.variables.set("pi", Math.PI);
		interp.variables.set("curMusicName", Main.curMusicName);
		interp.variables.set("Highscore", Highscore);
		interp.variables.set("HealthIcon", HealthIcon);
		interp.variables.set("debugTarget", debugTarget);
		interp.variables.set("switchTarget", switchTarget);
		interp.variables.set("EReg", EReg);
		interp.variables.set("StoryMenuState", StoryMenuState);
		interp.variables.set("FreeplayState", FreeplayState);
		interp.variables.set("CreditsState", CreditsState);
		interp.variables.set("SaveDataState", SaveDataState);
		interp.variables.set("DifficultyIcons", DifficultyIcons);
		interp.variables.set("Keyboard", Tooltip.Platform.Keyboard);
		interp.variables.set("Controls", Controls);
		interp.variables.set("Tooltip", Tooltip);
		interp.variables.set("SongInfoPanel", SongInfoPanel);
		interp.variables.set("DifficultyManager", DifficultyManager);
		interp.variables.set("flixelSave", FlxG.save);
		interp.variables.set("Record", Record);
		interp.variables.set("Math", Math);
		interp.variables.set("Song", Song);
		interp.variables.set("ModifierState", ModifierState);
		interp.variables.set("Reflect", Reflect);
		interp.variables.set("curStep", curStep);
		interp.variables.set("curBeat", curBeat);
		interp.variables.set("colorFromString", FlxColor.fromString);
		interp.variables.set("PlayState", PlayState);
		interp.variables.set("MenuItem", MenuItem);
		interp.variables.set("MenuCharacter", MenuCharacter);
		interp.variables.set("Math", Math);
		interp.variables.set("StringTools", StringTools);
		interp.variables.set("ChooseCharState", ChooseCharState);
		interp.variables.set("AttachedSprite", AttachedSprite);
		interp.variables.set("Paths", Paths);
		interp.variables.set("checkSpaces", checkSpaces);
		interp.variables.set("checkCreditsFile", checkCreditsFile);
		interp.variables.set("songs", songs);
		interp.variables.set("getCreditData", getCreditData);
		interp.variables.set("setCreditData", setCreditData);
		interp.variables.set("checkPrefix", checkPrefix);
		interp.variables.set("FlxTween", FlxTween);	
		interp.variables.set("FlxText", FlxText);
		interp.variables.set("FlxMath", FlxMath);
		interp.variables.set("FlxVideo", FlxVideo);
		interp.variables.set("FlxG", FlxG);	
		interp.variables.set("PlayStateChangeables", PlayStateChangeables);	
		interp.variables.set("PlayState", PlayState);	
		interp.variables.set("ModifierState", ModifierState);	
		interp.variables.set("VideoHandler", VideoHandler);	
		interp.variables.set("VideoHandlerMP4", VideoHandlerMP4);	
		interp.variables.set("MP4Handler", MP4Handler);	
		
		trace("set stuff");
		interp.execute(program);
		hscriptStates.set(usehaxe,interp);
		callHscript("create", [], usehaxe);
		trace('executed');
	}

	function checkSpaces(value:String):String
	{
		return (value.replace('\\n', '\n'));
		
	}

	function checkPrefix(value:String, prefix:String):Bool
	{
		return (value.startsWith(prefix));
	}

	function getCreditData(valA:Int, valB:Int):String
	{
		return (songs[valA][valB]);
	}

	function setCreditData(valA:Int, valB:Int, text:String):String 
	{
		songs[valA][valB] = text;
		return (songs[valA][valB]);
	}

	function checkCreditsFile(textFile:String):Void
	{
		var cArray = CoolUtil.coolTextFile(textFile);
		for(i in cArray)
		{
			var arr:Array<String> = i.split("::");
			//if(arr.length >= 5) arr.push(folder);
			songs.push(arr);
		}
		songs.push(['']);
	}

	override function create()
	{
		FNFAssets.clearStoredMemory();

		var cArray = CoolUtil.coolTextFile('assets/data/credits.txt');
		for(i in cArray)
		{
			var arr:Array<String> = i.replace('\\n', '\n').split("::");
			//if(arr.length >= 5) arr.push(folder);
			songs.push(arr);
		}
		songs.push(['']);
		
		makeHaxeState("credits", "assets/scripts/custom_menus/", "CreditsState");

		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		callAllHScript("update", [elapsed]);
	}

	override function stepHit()
	{
		super.stepHit();
		setAllHaxeVar('curStep', curStep);
		callAllHScript("stepHit", [curStep]);
	}

	override function beatHit()
	{
		super.beatHit();
		setAllHaxeVar('curBeat', curBeat);
		callAllHScript('beatHit', [curBeat]);
	}
}
