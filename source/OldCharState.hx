package;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.tweens.FlxTween;
import DifficultyIcons;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUI;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.addons.ui.FlxUITabMenu;
import lime.system.System;
import lime.app.Event;
import haxe.Json;
import tjson.TJSON;
using StringTools;


class OldCharState extends MusicBeatState
{
    public static var characters:Array<String>;
    var char:Character;
    var anim:String = PlayState.SONG.player1;
    var grpAlphabet:FlxTypedGroup<Alphabet>;

    var curSelected:Int = 0;
    var curChar:String = PlayState.SONG.player1;

    var dadMenu:Bool = false;
    private var iconArray:Array<HealthIcon> = [];
	var isPixelIcon:Array<Bool> = [];

    var charJson:Dynamic;
	var iconJson:Dynamic;
    var menuBG:FlxSprite;


    public function new(anim:String = "bf")
    {
        super();
        this.anim = anim;
    }

    override function create()
    {
        
        var isDebug:Bool = false;
		charJson = CoolUtil.parseJson(FNFAssets.getJson('assets/images/custom_chars/custom_chars'));
		iconJson = CoolUtil.parseJson(FNFAssets.getJson("assets/images/custom_chars/icon_only_chars"));
		#if debug
		isDebug = true;
		#end
        
        menuBG = new FlxSprite().loadGraphic('assets/images/menuDesat.png');
        menuBG.color = 0xFFea71fd;
        grpAlphabet = new FlxTypedGroup<Alphabet>();
        menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
        menuBG.updateHitbox();
        menuBG.screenCenter();
        menuBG.antialiasing = true;
        add(menuBG);

        var charJson:Dynamic = null;

        char = new Character(400, 100, anim);
        add(char);

        char.flipX = false;


    
        charJson = CoolUtil.parseJson(FNFAssets.getJson('assets/images/custom_chars/custom_chars'));

        if (characters == null) {
            // that is not how arrays work
            // characters = mergeArray(Reflect.fields(charJson), Reflect.fields(regCharacters)); // this doesn't work, try to make this work or just ignore it
            // reg characters should be first
            characters = Reflect.fields(charJson);
        }


        for(character in 0...characters.length){ //add chars
            var awesomeChar = new Alphabet(0, 10, "   "+characters[character], true, false, false);
            awesomeChar.isMenuItem = true;
            awesomeChar.targetY = character;
            grpAlphabet.add(awesomeChar);

            var icon:HealthIcon = new HealthIcon(characters[character]);
			icon.sprTracker = awesomeChar;
			// icons won't be visible 
			icon.visible = true;
            icon.xAdd = 50;
			iconArray.push(icon);
			add(icon);
        }

        add(grpAlphabet);
        trace("it's 11 pm"); //it's 12 pm

        super.create();

    }
    // i'd recommend moving smth like this to coolutil but w/e
    function mergeArray(base:Dynamic, ext:Dynamic){ //need this to combine regular chars and customs, CHANGE THIS if you know a better way
        var res = Reflect.copy(base);
        for(f in Reflect.fields(ext)) Reflect.setField(res,f,Reflect.field(res,f));
        return res;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        if (controls.BACK) {
			LoadingState.loadAndSwitchState(new ModifierState());
        }
        if (controls.UP_MENU)
        {
            changeSelection(-1);
        }
        if (controls.DOWN_MENU)
        {
            changeSelection(1);
        }

        if (controls.RIGHT_MENU || controls.LEFT_MENU) {
                swapMenus();
        }

        if (controls.ACCEPT)
            chooseSelection();
    }

    function changeSelection(change:Int = 0)
    {

        FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);

        curSelected += change;
        curChar = characters[curSelected].toString();

        if (curSelected < 0)
            curSelected = characters.length - 1;
        if (curSelected >= characters.length)
            curSelected = 0;


        var bullShit:Int = 0;

        for (i in 0...iconArray.length)
		{
			iconArray[i].alpha = 0.6;
		}

		iconArray[curSelected].alpha = 1;

        for (item in grpAlphabet.members)
        {
            item.targetY = bullShit - curSelected;
            bullShit++;

            item.alpha = 0.6;
            // item.setGraphicSize(Std.int(item.width * 0.8));

            if (item.targetY == 0)
            {
                item.alpha = 1;
                // item.setGraphicSize(Std.int(item.width));
            }
        }

        var coolors = ["black"];
		if (Reflect.hasField(charJson, characters[curSelected])) {
			coolors = Reflect.field(charJson, characters[curSelected]).colors;
		} else {
			coolors = Reflect.field(iconJson, characters[curSelected]).colors;
		}
		FlxTween.color(menuBG,0.5, menuBG.color, FlxColor.fromString(coolors[0]));
    }

    function chooseSelection()
    {
        remove(char);
        char.destroy();
        char = new Character(400, 100, curChar);
        if (!dadMenu) //cleaned up
        {
            char.flipX = true;
            PlayState.SONG.player1 = curChar;
            trace("BF is now " + curChar);
        }
        else
        {
            char.flipX = false;
            PlayState.SONG.player2 = curChar;
            trace("DAD is now " + curChar);
        }
        if (curChar == null)
            curChar = "bf";
        add(char);

    }
    // well yeah it lags you are creating a new character
    function swapMenus() { //this lags somewhat on my end so please try to optimize it
        FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt, 0.4);
        dadMenu = !dadMenu;
        remove(char);
        char.destroy();
        if (!dadMenu){ //cleaned this too
            char = new Character(400, 100, PlayState.SONG.player1);
            char.flipX = true;
        }
        else{
            char = new Character(400, 100, PlayState.SONG.player2);
            char.flipX = false;
        }
        add(char);
        trace('switchin the swag');
    }
}