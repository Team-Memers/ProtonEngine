package;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.system.FlxSoundGroup;
import flixel.math.FlxPoint;
import openfl.geom.Point;
import flixel.*;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.math.FlxMath;
import flixel.util.FlxStringUtil;
 /**
 hey you fun commiting people, 
 i don't know about the rest of the mod but since this is basically 99% my code 
 i do not give you guys permission to grab this specific code and re-use it in your own mods without asking me first.
 the secondary dev, ben
*/

/**

	hi

**/

class CharacterInSelect
{
	public var names:Array<String>;
	public var polishedNames:Array<String>;

	public function new(names:Array<String>, polishedNames:Array<String>)
	{
		this.names = names;
		this.polishedNames = polishedNames;
	}
}
class ChooseCharState extends MusicBeatState
{
	public var char:Boyfriend;
	public var char2:Boyfriend;
	public var current:Int = 0;
	public var curForm:Int = 0;
	public var characterText:FlxText;
	public var characterText2:FlxText;

	public var funnyIconMan:HealthIcon;
        public var isDad:Bool = false;
        public var isScript:Bool = false;

	var notestuffs:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];

	public var isDebug:Bool = false;

	public var PressedTheFunny:Bool = false;

	var selectedCharacter:Bool = false;

	var currentSelectedCharacter:CharacterInSelect;
	var currentSelectedCharacter2:CharacterInSelect;

	var noteMsTexts:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	//it goes left,right,up,down
	
	public var characters:Array<CharacterInSelect> = 
	[
		new CharacterInSelect(['bf', 'bf-christmas', 'bf-pixel', 'bf-holding-gf'], ["Boyfriend", 'Christmas Boyfriend', 'Pixel Boyfriend', 'BF Holding GF']),
		new CharacterInSelect(['pico'], ["Pico"]),
		new CharacterInSelect(['hankvs', 'antihank'], ["Accelerant Hank", "Antipathy Hank"]),
	];
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		Conductor.changeBPM(110);
		currentSelectedCharacter = characters[current];

		FlxG.save.data.unlockedcharacters = [true,true,true,true,true,true,true,true]; //unlock everyone hi

		var end:FlxSprite = new FlxSprite(0, 0);
		FlxG.sound.playMusic(Paths.music("charselect"),1,true);
		add(end);
		
		//create stage
		var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback'));
		bg.antialiasing = true;
		bg.scrollFactor.set(0.9, 0.9);
		bg.active = false;
		add(bg);

		var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront'));
		stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
		stageFront.updateHitbox();
		stageFront.antialiasing = true;
		stageFront.scrollFactor.set(0.9, 0.9);
		stageFront.active = false;
		add(stageFront);

		var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains'));
		stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
		stageCurtains.updateHitbox();
		stageCurtains.antialiasing = true;
		stageCurtains.scrollFactor.set(1.3, 1.3);
		stageCurtains.active = false;
		add(stageCurtains);

		FlxG.camera.zoom = 0.75;

		//create character
		char = new Boyfriend(FlxG.width / 2, FlxG.height / 2, "bf");
		char.screenCenter();
		char.y = 450;
		add(char);
		
		characterText = new FlxText((FlxG.width / 9) - 50, (FlxG.height / 8) - 225, "Boyfriend");
		characterText.font = 'VCR OSD Mono';
		characterText.setFormat('assets/fonts/vcr.ttf', 90, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		characterText.autoSize = false;
		characterText.fieldWidth = 1080;
		characterText.borderSize = 7;
		characterText.screenCenter(X);
                characterText.y += 100;
		add(characterText);
   

		funnyIconMan = new HealthIcon('char', true);
		funnyIconMan.visible = true;
		add(funnyIconMan);

		var tutorialThing:FlxSprite = new FlxSprite(-100, -100).loadGraphic(Paths.image('charSelectGuide'));
		tutorialThing.setGraphicSize(Std.int(tutorialThing.width * 1.5));
		tutorialThing.antialiasing = true;
		add(tutorialThing);

		var infoText = new FlxText(400, 400, 0, "Press F to switch from Player 1 to Player 2, Press G to switch the character select menu to the full customchars script", 4);
		infoText.font = 'VCR OSD Mono';
		infoText.setFormat('assets/fonts/vcr.ttf', 90, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.autoSize = false;
		infoText.fieldWidth = 1080;
		infoText.borderSize = 2;
                infoText.y += 100;
                infoText.size = 16;
		add(infoText);
	}

	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		//FlxG.camera.focusOn(FlxG.ce);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			LoadingState.loadAndSwitchState(new ModifierState());
		}

		if(FlxG.keys.justPressed.A)
		{
			{
				char.playAnim('singLEFT', true);
			}

		}
		if(FlxG.keys.justPressed.D)
		{
			{
				char.playAnim('singRIGHT', true);
			}
		}
		if(FlxG.keys.justPressed.W)
		{
			char.playAnim('singUP', true);
		}
		if(FlxG.keys.justPressed.S)
		{
			char.playAnim('singDOWN', true);
		}
		if (controls.ACCEPT)
		{
			if (PressedTheFunny)
			{
				return;
			}
			else
			{
				PressedTheFunny = true;
			}
			selectedCharacter = true;
			var heyAnimation:Bool = char.animation.getByName("hey") != null; 
			char.playAnim(heyAnimation ? 'hey' : 'singUP', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd'));
			new FlxTimer().start(1.9, endIt);
		}
		if (FlxG.keys.justPressed.LEFT && !selectedCharacter)
		{
			curForm = 0;
			current--;
			if (current < 0)
			{
				current = characters.length - 1;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (FlxG.keys.justPressed.RIGHT && !selectedCharacter)
		{
			curForm = 0;
			current++;
			if (current > characters.length - 1)
			{
				current = 0;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
		if (FlxG.keys.justPressed.DOWN && !selectedCharacter)
		{
			curForm--;
			if (curForm < 0)
			{
				curForm = characters[current].names.length - 1;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}

		if (FlxG.keys.justPressed.UP && !selectedCharacter)
		{
			curForm++;
			if (curForm > characters[current].names.length - 1)
			{
				curForm = 0;
			}
			UpdateBF();
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		}
	}

	public function UpdateBF()
	{
		funnyIconMan.color = FlxColor.WHITE;
		currentSelectedCharacter = characters[current];
		characterText.text = currentSelectedCharacter.polishedNames[curForm];
		char.destroy();
		char = new Boyfriend(FlxG.width / 2, FlxG.height / 2, currentSelectedCharacter.names[curForm]);
		char.screenCenter();
		char.y = 450;

		switch (char.curCharacter)
		{
	        default: char.y = 100;
		}
		add(char);
		funnyIconMan = new HealthIcon('char');
		characterText.screenCenter(X);
	}

	override function beatHit()
	{
		super.beatHit();
		if (char != null && !selectedCharacter)
		{
			char.playAnim('idle');
		}
	}
	
	
	public function endIt(e:FlxTimer = null)
	{
if (isDad == false)
   {
		trace("ENDING");
		PlayState.SONG.player1 = currentSelectedCharacter.names[0];
		PlayState.formoverride = currentSelectedCharacter.names[curForm];
		PlayState.curmult = [1, 1, 1, 1];
		LoadingState.loadAndSwitchState(new ModifierState());
   }
if (isDad == true)
   {
		trace("ENDING");
		PlayState.SONG.player2 = currentSelectedCharacter.names[0];
		PlayState.formoverride = currentSelectedCharacter.names[curForm];
		PlayState.curmult = [1, 1, 1, 1];
		LoadingState.loadAndSwitchState(new ModifierState());
   }
	}
	
}
