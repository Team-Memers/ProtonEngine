package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.atlas.FlxAtlas;
import lime.system.System;
import lime.utils.Assets;
#if sys
import sys.io.File;
import sys.FileSystem;
import haxe.io.Path;
import openfl.utils.ByteArray;
import lime.media.AudioBuffer;
import flash.media.Sound;
#end

import hscript.Interp;
import hscript.Parser;
import hscript.ParserEx;
import hscript.InterpEx;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

import haxe.Json;
import tjson.TJSON;
using StringTools;
class GameOverSubstate extends MusicBeatSubstate
{
	var hscriptStates:Map<String, Interp> = [];
	var exInterp:InterpEx = new InterpEx();
	var haxeSprites:Map<String, FlxSprite> = [];

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
		interp.variables.set("controls", controls);
		interp.variables.set("MainMenuState", MainMenuState);
		interp.variables.set("CategoryState", CategoryState);
		interp.variables.set("ChartingState", ChartingState);
		interp.variables.set("Alphabet", Alphabet);
		interp.variables.set("curBeat", 0);
		interp.variables.set("currentState", this);
		interp.variables.set("add", add);
		interp.variables.set("remove", remove);
		interp.variables.set("insert", insert);
		interp.variables.set("pi", Math.PI);
		interp.variables.set("curMusicName", Main.curMusicName);
		interp.variables.set("Highscore", Highscore);
		interp.variables.set("HealthIcon", HealthIcon);
		interp.variables.set("LoadingState", LoadingState);
		interp.variables.set("DialogueBox", DialogueBox);
		interp.variables.set("StoryMenuState", StoryMenuState);
		interp.variables.set("FreeplayState", FreeplayState);
		interp.variables.set("CreditsState", CreditsState);
		interp.variables.set("SaveDataState", SaveDataState);
		interp.variables.set("DifficultyIcons", DifficultyIcons);
		interp.variables.set("Controls", Controls);
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
		interp.variables.set("NewCharacterState", NewCharacterState);
		interp.variables.set("NewStageState", NewStageState);
		interp.variables.set("NewSongState", NewSongState);
		interp.variables.set("NewWeekState", NewWeekState);
		interp.variables.set("SelectSortState", SelectSortState);
		interp.variables.set("CategoryState", CategoryState);
		interp.variables.set("ControlsState", ControlsState);
		interp.variables.set("FlxObject", FlxObject);
		
		trace("set stuff");
		interp.execute(program);
		hscriptStates.set(usehaxe,interp);
		callHscript("create", [], usehaxe);
		trace('executed');
	}

	public function new(x:Float, y:Float, ?isPlayer:Bool = true)
	{
		super();
		makeHaxeState("gameover", "assets/scripts/custom_menus/", "GameOverSubstate");
		callAllHScript("start", [x, y, isPlayer]);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		callAllHScript("update", [elapsed]);
	}

	override function beatHit()
	{
		super.beatHit();
		FlxG.log.add('beat');
		setAllHaxeVar('curBeat', curBeat);
		callAllHScript('beatHit', [curBeat]);
	}

	override function stepHit()
	{
		super.stepHit();
		setAllHaxeVar('curStep', curStep);
		callAllHScript("stepHit", [curStep]);
	}
}
