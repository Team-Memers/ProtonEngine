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
		new CharacterInSelect(['bf', 'bf-christmas', 'bf-pixel', 'bf-holding-gf', 'girlbf', 'bbibf', 'beachbf', 'bfflippy', 'evilbf', 'evilbfdemon', 'bfwii', 'salty', 'bsidebf', 'bsidecbf', 'bsidepbf', 'dsidebf', 'neobf', 'softbf', 'b3bf', 'corruptionbf', 'ena', 'xianxibf', 'bfv', 'bfbb', 'spookythecat', 'rappergf', 'playablespooky', 'photoshopbf', 'oldbf', 'brewstew', 'bfex', 'bf3d'], ["Boyfriend", 'Christmas Boyfriend', 'Pixel Boyfriend', 'BF Holding GF', 'Girl Boyfriend', 'Blueballs Incident Boyfriend', 'Beach Boyfriend', 'Flipped Out Boyfriend', 'Soul BF', "Soul BF (Demon)", 'Mii Boyfriend', 'Salty', 'B-Sides Boyfriend', "B-Sides Boyfriend (Christmas)", "B-Sides Boyfriend (Pixel)", 'D-Sides Boyfriend', 'Neo Boyfriend', 'Soft Boyfriend', 'B3 Remixed Boyfriend', 'Corruption Boyfriend', 'ENA', 'Xianxi Boyfriend', '/v/-tan Boyfriend', 'Background Boogie Boyfriend', 'Jinx', 'Rapper Girlfriend', 'Playable Spooky Kids', 'Photoshop Boyfriend', 'Paradox Boyfriend', 'BrewStew', 'EX Boyfriend', '3D Boyfriend']),
		new CharacterInSelect(['bf', 'superbf', 'bfdoki', 'bfexepixel', 'bfghost', 'bfkendo', 'bfmii', 'bfpixelskeld', 'bfwimpy', 'bwbf', 'infidelitybf', 'sticky', 'complexkidstv', 'joker', 'bsidejoker', 'playableneonight', 'corruptionglitchbf', 'cum', 'hdbf2', 'infinitebf', 'loggobf', 'minusbf', 'minusbf2', 'minusbf3', 'bfwire', 'tari', 'tardbf', 'tardbf2', 'tardbf3', 'sonicbf', 'shyrell'], ['Boyfriend Page 2', 'Super Boyfriend', 'Doki Doki Boyfriend', "Boyfriend Pixel (EXE)", 'Ghost Boyfriend', 'Kendo Boyfriend', "Mii Boyfriend (Boss Rush)", "Boyfriend Pixel (Skeld)", 'Wimpy Boyfriend', 'Black and White Boyfriend', 'Infidelity Boyfriend', 'StickyBM', 'ComplexKidsTV', 'Joker', 'B-Sides Joker', 'Neonight', 'Corruption Glitch Boyfriend', 'cum', 'HD Boyfriend', 'Infinite Boyfriend', "Loggo Boyfriend", "Beta Boyfriend", "Blue Boyfriend", "Mean Boyfriend", "Wireframe Boyfriend", 'Tari', "Troll Boyfriend (Chapter 1)", "Troll Boyfriend (Chapter 2)", "Troll Boyfriend (Chapter 3)", "Sonic the Hedgehog", "Shyrell"]),
		new CharacterInSelect(['bf', 'seabf', 'cartman', 'corruptionbfpixel4', 'fever', 'freeman', 'gunbf', 'smg4mario', 'bfreanimated', 'bfaurora', 'playablelylace', 'phantombf', 'tigersoldier', 'coolbf', 'bfgb', 'bffatal', 'bfwacky', "minimum_wage", 'bfnitty', 'bfball', 'richter'], ['Boyfriend Page 3', "TeamSeas Boyfriend", "Eric Cartman (I use any pronouns thank you for asking)", "Corruption BF (Pixel)", "Fever", "Gordon Freeman", "Boyfriend with a Gun", "SMG4 Mario", "Boyfriend (Reanimated)", "Boyfriend (Angry)", "Lylace", "Phantom Boyfriend", "Tiger Soldier", "Cool Boyfriend", "Boyfriend (Golden Land)", "Boyfriend (Fatality)", "Boyfriend (Wacky)", "Boyfriend (Minimum Wage)", "The Boof", "Boyfriend (BALLIN)", "Richter"]),
		new CharacterInSelect(['pico', 'bsidepico', 'dsidepico', 'neopico', 'corruptionpicodm', 'bfpico', 'corruptionglitchpico', 'minuspico', 'stickpico'], ['Pico', 'B-Sides Pico', 'D-Sides Pico', 'Neo Pico', 'Corrupted Pico', "Shootin' Pico", 'Corruption Glitch Pico', "Minus Pico", 'Stickfigure Pico']),
		new CharacterInSelect(['hankvs', 'antihank', 'highefforthank', 'hankmask', 'hank', 'maghank', 'hankvsr', 'whitehanka'], ['Accelerant Hank', 'Antipathy Hank', 'High Effort Hank', 'Hank over Tricky', "Hank over Tricky (Unmasked)", 'MAG Hank', "Accelerant Hank (Reanimated)", "White Hank (Fanmade)"]),
		new CharacterInSelect(['tankman', 'hetankman'], ['Tankman', 'High Effort Tankman']),
		new CharacterInSelect(['majinsonicnew', 'majinsonic', 'majinsonic2', 'majinsex', 'mazinsonic'], ['Majin Sonic', "Majin Sonic (Old)", "Majin Sonic (Chaotic Endeavors)", "Majin Sonic (Sex)", "Mazin Sonic"]),
		new CharacterInSelect(['xianxihf', 'akuma', 'xianxi', 'xianxihfpoop', 'xianxihfpoop2', 'chxca', 'chxcabutreal', 'realchxca', 'poopfart'], ['Akuma', 'Hell Akuma', 'Xianxi', "Xianxi (Old)", "Xianxi (Old 2)", "chxca", "chxca but real", "real chxca", "Poopfart"]),
		new CharacterInSelect(['pootisre', 'pootisreal', 'pootiscrazed', 'soulpootis', 'soulpootisoverlay', 'pootisycr', 'fakerpootisexe', 'pootistv', 'pootiscys', 'poopis', 'poopisalt', 'pootis'], ["DaPootisBird", "DaPootisBird (Old)", "DaPootisBird (Crazed)", "DaPootisBird (Soul)", "DaPootisBird (Soul Overlay)", "DaPootisBird (YCR)", "DaPootisBird (FAKER FAKER FAKER FAKER FAKER)", "Pootis (TV)", "Pootis (CYS)", "Poopis", "Poopis (Alt)", 'Poop']),
		new CharacterInSelect(['eteled', 'eteledinsane', 'eteledinsane2', 'eteledcreepy', 'eteledcreepy2', 'eteledboss', 'eteledboss2', 'minuseteled', 'minuseteledcrazed'], ['eteled', "eteled (Insane)", "eteled (Insane 2)", "eteled (Creepy)", "eteled (Creepy 2)", "eteled (Boss Rush)", "eteled (Boss Rush 2)", "Minus eteled", "Minus eteled (Crazed)"]),
		new CharacterInSelect(['austin', 'austinglitch'], ['Austin', "Austin (Glitch)"]),
		new CharacterInSelect(['derpmaster', 'spookmaster', 'fakerderp'], ['DerpMaster', 'SpookMaster', 'FAKER FAKER FAKER FAKER FAKER FAKER FAKER FAKER FAKER FAKER FAKER FAKER']),
		new CharacterInSelect(['v-tan', 'v-tancalm', 'v-tanmic'], ["/v/-tan", "/v/-tan (Calm)", "/v/-tan (Mic)"]),
		new CharacterInSelect(['cancer2d', 'cancer', 'supercancer'], ['Cancer Lord', "Cancer Lord (Flipped Perspective)", "Cancer Lord (Super)"]),
		new CharacterInSelect(['flippy', 'flippyslaughter', 'flippyneil', 'flippyeteled', 'flippypissed', 'flippykp'], ['Fliqpy', "Fliqpy (Slaughter)", 'Neil Cicierega', "Fliqpy (eteled)", "Fliqpy (Pissed)", "Fliqpy (KAPOW!)"]),
		new CharacterInSelect(['trolls1', 'trollr1', 'trolli1', 'trollre'], ["Smiler (Sad)", "Smiler (Angry)", "Smiler (Trolling)", "Smiler (Redemption)"]),
		new CharacterInSelect(['sonic.exe','sonic.exep2', 'xenophanes', 'sonic.exe2', 'sonic.exe3', 'sonic.exepixelbetter', 'sonic.exepixel', 'sonic.exeslaybells', 'sonic.exehotv', 'sonic.exep2beta', 'sonic.exep2lean', 'leanophanes'], ['Sonic.exe', "Sonic.exe (You Can't Run)", 'Xenophanes', "Sonic.exe (YCR Fanmade)", "Sonic.exe (Chaotic Endeavors)", "Sonic.exe (YCR Pixel Better)", "Sonic.exe (YCR Pixel)", "Sonic.exe (Slaybells)", "Sonic.exe (Hill of the Void)", "Sonic.exe (YCR Beta)", "Sonic.exe (Lean Edition)", "Leanophanes"]),
		new CharacterInSelect(['shadowbonniere', 'shadowbonnieremaster', 'shadowbonnie', 'foreheadman', 'demonbonnie', 'godbonnie'], ['Shadowbonnie', "Shadowbonnie (Old)", "Shadowbonnie (Older)", "Forehead Man", 'Bizzarobonnie', "GODBONNIE"]),
		new CharacterInSelect(['playablesenpai','senpai', 'senpai-angry', 'spirit', '2vplussenpai', '2vplussenpaiangry', 'hdsenpai', 'hdsenpaiangry', 'hdsenpaispirit', 'bsidesenpai', 'bsideasenpai', 'bsidespirit', 'susspirit', 'corruptionsenpaiangry', 'corruptionspirit', "glitch", "glitchangry", "glitchdestroyed"], ['Senpai', "Senpai but not playable", "Senpai (Angry)", 'Spirit', "2VPLUS Senpai", "2VPLUS Senpai (Angry)", "HD Senpai", "HD Senpai (Angry)", "HD Senpai (Spirit)", "B-Sides Senpai", "B-Sides Senpai (Angry)", "B-Sides Spirit", "SUS SPIRIT!!!", "Corruption Senpai (Angry)", "Corruption Spirit", "Glitch", "Glitch (Angry)", "Glitch (Destroyed)"]),
		new CharacterInSelect(['lordxnew','lordxfatenew', 'lordxfate', 'lordx', 'lordxbroken', 'lordxslaybells', 'lordxhd', 'lordsex'], ['Lord X', "Lord X (Fate)", "Lord X (Fate Old)", "Lord X (Old)", "Lord X (Broken)", "Lord X (Slaybells)", "Lord X (HD)", "Lord SeX"]),
		new CharacterInSelect(['aldryx'], ['Aldryx Andromeda']),
		new CharacterInSelect(['vsgf', 'gfhypno'], ['Girlfriend', 'Lullaby Girlfriend']),
		new CharacterInSelect(['brownmario', 'brownmarioangry', 'brownmarioinsane'], ['Brown Mario', "Brown Mario (Angry)", "Brown Mario (Insane)"]),
		new CharacterInSelect(['brownluigi'], ["Brown Luigi"]),
		new CharacterInSelect(['agoti', 'agotipissed'], ["A.G.O.T.I", "A.G.O.T.I (Pissed)"]),
		new CharacterInSelect(['solazar'], ["Solazar"]),
		new CharacterInSelect(['bbpanzu'], ["bbpanzu"]),
		new CharacterInSelect(['whitty', 'whittycrazy', 'agrowhitty', 'corruptionwhittydm'], ["Whitty", "Whitty (Crazy)", "Whitty (Agro)", "Corruption Whitty"]),
		new CharacterInSelect(['redimpostor', 'redimpostorpissed'], ["Red Impostor", "Red Impostor (Scared)"]),
		new CharacterInSelect(['greencrewmate', 'greenimpostor', 'greenimpostordark', 'greenparasite'], ["Green Crewmate", "Green Impostor", "Green Impostor (Dark)", "Green Parasite"]),
		new CharacterInSelect(['blackimpostor'], ["Black Impostor"]),
		new CharacterInSelect(['sonic', 'sonicpissed', 'sonicforced', 'sonicdark', 'scourge', 'scourgeangry', 'scourgeforced'], ["TGT Sonic", "TGT Sonic (Angry)", "TGT Sonic (Forced)", "TGT Sonic (Dark)", "TGT Scourge", "TGT Scourge (Angry)", "TGT Scourge (Forced)"]),
		new CharacterInSelect(['tails', 'tailsswag'], ["TGT Tails", "TGT Tails (Swag)"]),
		new CharacterInSelect(['monika', 'monikareal', 'hdmonika'], ["Monika", "Monika (Real)", "HD Monika"]),
		new CharacterInSelect(['sayori'], ["Sayori"]),
		new CharacterInSelect(['natsuki'], ["Natsuki"]),
		new CharacterInSelect(['yuri', 'yuricrazy'], ["Yuri", "Yuri (Crazy)"]),
		new CharacterInSelect(['bob', 'bobannoyed', 'bobhell', 'bobgloop', 'bobonslaught', 'gloopie'], ["Bob", "Bob (Annoyed)", "run", "Bob (Gloop)", "onslaught", "Gloopie"]),
		new CharacterInSelect(['ron', 'ronsip'], ["Ron", "Ronsip"]),
		new CharacterInSelect(['bobgd', 'worriedbob', 'bobex'], ["Bob (Bob and Bosip)", "Bob (Worried)", "EX Bob"]),
		new CharacterInSelect(['bosip', 'bosipex'], ["Bosip", "EX Bosip"]),
		new CharacterInSelect(['sadmouse', 'happymouse', 'suicidemouse', 'bipolarmouse', 'sadmouser', 'happymouser', 'suicidemouser'], ["Suicide Mouse (Sad)", "Suicide Mouse (Happy)", "Suicide Mouse", "Suicide Mouse (Insane)", "Suicide Mouse (Sad Remastered)", "Suicide Mouse (Happy Remastered)", "Suicide Mouse (Remastered)"]),
		new CharacterInSelect(['smilemouse'], ["Alt Suicide Mouse"]),
		new CharacterInSelect(['infidelitymouse', 'infidelitymouse2', 'infidelitymouse3', 'infidelitymouse4', 'infidelitymouse5', 'infidelitymouse6', 'infidelitymousehank'], ["Suicide Mouse (Infidelity)", "Suicide Mouse (Infidelity Happy)", "Suicide Mouse (Infidelity Losing Sanity)", "Suicide Mouse (Infidelity Very Happy)", "Suicide Mouse (Infidelity Crazy)", "Suicide Mouse (Infidelity Insane)", "Suicide Mouse (Infidelity Hank)"]),
		new CharacterInSelect(['casandragood', 'casspider'], ["Casandra", "Casandra (Spider)"]),
		new CharacterInSelect(['jebus'], ["Jebus Christ"]),
		new CharacterInSelect(['skippa', 'egoskippa'], ["Skipper", "EGO Skipper"]),
		new CharacterInSelect(['sunky'], ["Sunky.mpeg"]),
		new CharacterInSelect(['tails.exe', 'tailsnotexe', 'tails.exedark'], ["Tails.exe", "Tails?", "Tails.exe (Dark)"]),
		new CharacterInSelect(['knuckles.exe'], ["Knuckles.exe"]),
		new CharacterInSelect(['robotnik.exe'], ["Robotnik.exe"]),
		new CharacterInSelect(['fleetway'], ["Fleetway Super Sonic"]),
		new CharacterInSelect(['spiderman'], ["Spiderman"]),
		new CharacterInSelect(['edd'], ["Edd Gould"]),
		new CharacterInSelect(['tordvs'], ["Tord Larsson"]),
		new CharacterInSelect(['dorklysonic'], ["Dorkly Sonic"]),
		new CharacterInSelect(['dorklyknuckles'], ["Dorkly Knuckles"]),
		new CharacterInSelect(['shadow', 'shadowcrazy', 'shadowhigh'], ["TGT Shadow", "TGT Shadow (Pissed)", "TGT Shadow (High)"]),
		new CharacterInSelect(['disabilitydave', 'davetp'], ["Disability Dave", "Dave (Triple Phonebreakers)"]),
		new CharacterInSelect(['mrtrololo', 'mrtrololocough'], ["Mr. Trololo/The Baritone", "Mr. Trololo/The Baritone (Sick)"]),
		new CharacterInSelect(['trollge'], ["The Maestro"]),
		new CharacterInSelect(['juilan', 'juilanswag', 'juilanswagger', 'juilanwacky', 'the-burger', 'juilanwackyhqr'], ["Julian T. Whitmore", "Julian T. Whitmore (Swag)", "Julian T. Whitmore (Swagger)", "Julian T. Whitmore (Wacky)", "Julian T. Whitmore (Hungry)", "Julian T. Whitmore (Wacky HQR)"]),



	];
	public function new() 
	{
		super();
	}
	
	override public function create():Void 
	{
		super.create();
		Conductor.changeBPM(110);
		if(PlayState.SONG.song.toLowerCase() == 'thigh-highs' || PlayState.SONG.song.toLowerCase() == 'homelesschrome')
		{
			characters = [new CharacterInSelect(['sonic.exe','sonic.exep2', 'xenophanes', 'sonic.exe2', 'sonic.exe3', 'sonic.exepixel', 'sonic.exeslaybells', 'sonic.exehotv'], ['Sonic.exe', "Sonic.exe (You Can't Run)", 'Xenophanes', "Sonic.exe (YCR Fanmade)", "Sonic.exe (Chaotic Endeavors)", "Sonic.exe (YCR Pixel)", "Sonic.exe (Slaybells)", "Sonic.exe (Hill of the Void)"])];
		}
		if(isScript == true)
		{
			characters = [new CharacterInSelect(['bf'], ["if you actually managed to find this, this is a work in progress. this is meant to load the custom chars json so it can include the full character list, instead of a manual one"])];
		}
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