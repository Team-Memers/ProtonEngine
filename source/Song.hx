package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;
import tjson.TJSON;
#if sys
import sys.io.File;
import lime.system.System;
import haxe.io.Path;
#end
using StringTools;

typedef SwagSong =
{
	var song:String;
	var events:Array<Dynamic>;
	var notes:Array<SwagSection>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var stage:String;
	var gf:String;
	var isMoody:Null<Bool>;
	var cutsceneType:String;
	var countdownType:String;
	var isVixtinCustomVocals:Null<Bool>;
	var uiType:String;
        var uiLayoutType:String;
	var isSpooky:Null<Bool>;
	var isHey:Null<Bool>;
	var isCheer:Null<Bool>;
	var preferredNoteAmount:Null<Int>;
	var forceJudgements:Null<Bool>;
	var convertMineToNuke:Null<Bool>;
	var mania:Null<Int>;
	var stageID:Null<Int>;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var events:Array<Dynamic>;
	public var bpm:Int;
	public var needsVoices:Bool = true;
	public var speed:Float = 1;

	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var stage:String = 'stage';
	public var gf:String = 'gf';
	public var isMoody:Null<Bool> = false;
	public var isSpooky:Null<Bool> = false;
	public var isVixtinCustomVocals:Null<Bool> = false;
	public var cutsceneType:String = "none";
	public var uiType:String = 'normal';
	public var uiLayoutType:String = 'normal';
	public var countdownType:String = 'normal';
	public var isHey:Null<Bool> = false;
	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		var rawJson:String = "";
		if (jsonInput != folder && FNFAssets.exists("assets/data/" + folder.toLowerCase() + "/" + folder.toLowerCase() + ".json"))
		{
			// means this isn't normal difficulty
			// raw json 

			rawJson = FNFAssets.getText("assets/data/"+folder.toLowerCase()+"/"+folder.toLowerCase()+".json").trim();
		} else {
			rawJson = FNFAssets.getText("assets/data/" + folder.toLowerCase() + "/" + jsonInput.toLowerCase() + '.json').trim();
		}

		if (jsonInput == 'events')
		{
			rawJson = FNFAssets.getText("assets/data/" + folder.toLowerCase() + "/" + jsonInput.toLowerCase() + '.json').trim();
		}
		
		while (!rawJson.endsWith("}"))
		{
			rawJson = rawJson.substr(0, rawJson.length - 1);
			// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
		}
		var parsedJson = parseJSONshit(rawJson);
		if (parsedJson.stage == null) {
			// sw-switch case :fuckboy:
			parsedJson.stage = switch (parsedJson.song.toLowerCase()) {
				case 'spookeez' | 'monster' | 'south':
					'spooky';
				case 'philly' | 'pico' | 'blammed':
					'philly';
				case 'milf' | 'high' | 'satin-panties':
					'limo';
				case 'cocoa' | 'eggnog':
					'mall';
				case 'winter-horrorland':
					'mallEvil';
				case 'senpai' | 'roses':
					'school';
				case 'thorns':
					'schoolEvil';
				case 'ugh' | 'stress' | 'guns':
					'tank';
				default:
					'stage';
			
			}
		}
		if (parsedJson.isHey == null) {
			parsedJson.isHey = false;
			if (parsedJson.song.toLowerCase() == 'bopeebo')
				parsedJson.isHey = true;
		}
		if (parsedJson.isCheer = null) {
			parsedJson.isCheer = false;
			if (parsedJson.song.toLowerCase() == "tutorial") {
				parsedJson.isCheer = true;
			}
		}

		if(parsedJson.events == null)
		{
			parsedJson.events = [];
			for (secNum in 0...parsedJson.notes.length)
			{
				var sec:SwagSection = parsedJson.notes[secNum];

				var i:Int = 0;
				var notes:Array<Dynamic> = sec.sectionNotes;
				var len:Int = notes.length;
				while(i < len)
				{
					var note:Array<Dynamic> = notes[i];
					if(note[1] < 0)
					{
						parsedJson.events.push([note[0], [[note[2], note[3], note[4]]]]);
						notes.remove(note);
						len = notes.length;
					}
					else i++;
				}
			}
		}
		if (parsedJson.preferredNoteAmount == null) {
			switch (parsedJson.mania) {
				case 1:
					parsedJson.preferredNoteAmount = 6;
				case 2:
					parsedJson.preferredNoteAmount = 9;
				default:
					parsedJson.preferredNoteAmount = 4;
			}
		}
		if (parsedJson.mania == null) {
			switch (parsedJson.preferredNoteAmount) {
				case 4:
					parsedJson.mania = 0;
				case 6:
					parsedJson.mania = 1;
				case 9:
					parsedJson.mania = 2;
				default:
					parsedJson.mania = 0;
			}
		}
		trace(parsedJson.stage);
		if (parsedJson.gf == null) {
			// are you kidding me did i really do song to lowercase
			switch (parsedJson.stage) {
				case 'limo':
					parsedJson.gf = 'gf-car';
				case 'mall':
					parsedJson.gf = 'gf-christmas';
				case 'mallEvil':
					parsedJson.gf = 'gf-christmas';
				case 'school' 
				| 'schoolEvil':
					parsedJson.gf = 'gf-pixel';
				case 'tank':
					parsedJson.gf = 'gf-tankmen';
					if (parsedJson.song.toLowerCase() == "stress") {
						parsedJson.gf = "pico-speaker";
					}
				default:
					parsedJson.gf = 'gf';
			}

		}
		if (parsedJson.isMoody == null) {
			if (parsedJson.song.toLowerCase() == 'roses') {
				parsedJson.isMoody = true;
			} else {
				parsedJson.isMoody = false;
			}
		}
		// is spooky means trails on spirit
		if (parsedJson.isSpooky == null) {
			if (parsedJson.stage.toLowerCase() == 'mallEvil') {
				parsedJson.isSpooky = true;
			} else {
				parsedJson.isSpooky = false;
			}
		}
		if (parsedJson.song.toLowerCase() == 'winter-horrorland') {
			parsedJson.cutsceneType = "monster";
		}
		if (parsedJson.forceJudgements == null) {
			parsedJson.forceJudgements = false;
		}
		if (parsedJson.cutsceneType == null) {
			switch (parsedJson.song.toLowerCase()) {
				case 'roses':
					parsedJson.cutsceneType = "angry-senpai";
				case 'senpai':
					parsedJson.cutsceneType = "senpai";
				case 'thorns':
					parsedJson.cutsceneType = 'spirit';
				case 'winter-horrorland':
					parsedJson.cutsceneType = 'monster';
				default:
					parsedJson.cutsceneType = 'none';
			}
                }
		if (parsedJson.countdownType == null) {
			switch (parsedJson.song.toLowerCase()) {
				default:
					parsedJson.countdownType = 'normal';
			}
		}
		if (parsedJson.convertMineToNuke == null) {
			if (parsedJson.song.toLowerCase() == "expurgation")
				parsedJson.convertMineToNuke = true;
			else
				parsedJson.convertMineToNuke = false;
		}
		if (parsedJson.uiType == null) {

			parsedJson.uiType = switch (parsedJson.song.toLowerCase()) {
				case 'roses' | 'senpai' | 'thorns':
					'pixel';
				default:
					'normal';
			}
		}
		if (parsedJson.uiLayoutType == null) {

			parsedJson.uiLayoutType = switch (parsedJson.song.toLowerCase()) {
				default:
					'normal';
			}
		}
// FUCK THIS FUCKING GAME
// SERIOUSLY CAN'T GET JACKSHIT DONE BECAUSE OF SHIT SUDDENLY BREAKING
		if (parsedJson.stageID == null) {
			parsedJson.stageID == 0;
		}
		if (parsedJson.player1 == "bf-pixel" && OptionsHandler.options.stressTankmen) {
			parsedJson.player1 = "bulb-pixel";
		}
		// FIX THE CASTING ON WINDOWS/NATIVE
		// Windows???
		// trace(songData);

		// trace('LOADED FROM JSON: ' + songData.notes);
		/*
			for (i in 0...songData.notes.length)
			{
				trace('LOADED FROM JSON: ' + songData.notes[i].sectionNotes);
				// songData.notes[i].sectionNotes = songData.notes[i].sectionNotes
			}

				daNotes = songData.notes;
				daSong = songData.song;
				daSections = songData.sections;
				daBpm = songData.bpm;
				daSectionLengths = songData.sectionLengths; */
		if (jsonInput != folder)
		{
			// means this isn't normal difficulty
			// lets finally overwrite notes
			var realJson = parseJSONshit(FNFAssets.getText("assets/data/" + folder.toLowerCase() + "/" + jsonInput.toLowerCase() + '.json').trim());
			parsedJson.notes = realJson.notes;
			parsedJson.bpm = realJson.bpm;
			parsedJson.needsVoices = realJson.needsVoices;
			parsedJson.speed = realJson.speed;
		}
		return parsedJson;
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		var swagShit:SwagSong = cast CoolUtil.parseJson(rawJson).song;
		return swagShit;
	}
}
