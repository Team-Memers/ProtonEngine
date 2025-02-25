package;

import flixel.FlxG;
import openfl.display.BitmapData;
import flixel.FlxSprite;
import lime.utils.Assets;
import lime.system.System;
import flixel.graphics.FlxGraphic;
import tjson.TJSON;
using StringTools;


class CoolUtil
{
	public static var fps:Int = 60;
	// hxs, like kotlin's kts
	public static final HSCRIPT_EXT:Array<String> = ['hscript', 'hxs'];
	public static final JSON_EXT:Array<String> = ['json', 'jsonc'];
	public static var defaultDifficulties:Array<String> = [
		'Easy',
		'Normal',
		'Hard'
	];
	public static var defaultDifficulty:String = 'Normal'; //The chart that has no suffix and starting difficulty on Freeplay/Story Mode

	public static var difficulties:Array<String> = [];
	public static function coolTextFile(path:String):Array<String>
	{
		var daList:Array<String> = FNFAssets.getText(path).trim().split('\n');

		for (i in 0...daList.length)
		{
			daList[i] = daList[i].trim();
		}

		return daList;
	}
	public static function coolDynamicTextFile(path:String):Array<String>
	{
		return coolTextFile(path);
	}
	inline public static function boundTo(value:Float, min:Float, max:Float):Float {
		return Math.max(min, Math.min(max, value));
	}
	public static function numberArray(max:Int, ?min = 0):Array<Int>
	{
		var dumbArray:Array<Int> = [];
		for (i in min...max)
		{
			dumbArray.push(i);
		}
		return dumbArray;
	}
	public static function clamp(mini:Float, maxi:Float, value:Float):Float {
		return Math.min(Math.max(mini,value), maxi);
	}
	// can either return an array or a dynamic
	public static function parseJson(json:String):Dynamic {
		// the reason we do this is to make it easy to swap out json parsers
		return TJSON.parse(json);
	}
	public static function stringifyJson(json:Dynamic, ?fancy:Bool = true):String {
		// use tjson to prettify it
		var style:String = if (fancy) 'fancy' else null;
		return TJSON.encode(json,style);
	}
	// include all helper functions to keep shit in the same place
	public static function truncateFloat(number:Float, precision:Int):Float {
		return HelperFunctions.truncateFloat(number, precision);
	}
	public static function erf(x:Float):Float {
		return HelperFunctions.erf(x);
	}
	public static function getNotes():Int {
		return HelperFunctions.getNotes();
	}
	public static function getHolds():Int {
		return HelperFunctions.getHolds();
	}
	public static function getMapMaxScore():Int {
		return HelperFunctions.getMapMaxScore();
	}
	public static function wife3(maxms:Float, ts:Float)
	{
		return HelperFunctions.wife3(maxms, ts);
	}
	public static function browserLoad(site:String) {
		#if linux
		Sys.command('/usr/bin/xdg-open', [site]);
		#else
		FlxG.openURL(site);
		#end
	}

	public static inline function exactSetGraphicSize(obj:Dynamic, width:Float, height:Float) // ACTULLY WORKS LMAO -lunar
	{
		obj.scale.set(Math.abs(((obj.width - width) / obj.width) - 1), Math.abs(((obj.height - height) / obj.height) - 1));
	}
}

class FlxTools {
	// Load a graphic and ensure it exists
	static public function loadGraphicDynamic(s:FlxSprite, path:String, animated:Bool=false, width:Int=0, height:Int=0, unique:Bool=false, ?key:String):FlxSprite {
		var sus:BitmapData = FNFAssets.getBitmapData(path);
		s.loadGraphic(sus,animated,width,height,unique,key);
		return s;
	}
}