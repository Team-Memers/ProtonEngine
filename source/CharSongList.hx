package;

class CharSongList
{
    public static var data:Map<String,Array<String>> = [
      "Xenophanes" => ["too-slow", "too-slow-encore", "you-cant-run"],
      "Xenophanes Part 2" => ["you-cant-run-encore", "triple-trouble", "triple-trouble-encore-knuckles"],
      "Xenophanes Part 3" => ["too-slow-old", "you-cant-run-old", "triple-trouble-old"],
      "Majin Sonic" => ["endless", "endless-og", "endless-us"],
      "Majin Sonic Part 2" => ["endless-jp", "endless-encore", "endeavors"],
      "Lord X" => ["cycles", "cycles-old", "fate"],
      "Lord X Part 2" => ["hellbent", "gotta-go", "execution"],
      "Tails Doll" => ["sunshine-", "soulless"],
      "Fleetway Super Sonic" => ["chaos"],
      "Fatal Error" => ["fatality"],
      "Chaotix" => ["my-horizon", "our-horizon"],
      "Curse" => ["malediction"],
      "Starved" => ["prey", "fight-or-flight"],
      "X-Terion" => ["substantial", "digitalized"],
      "Needlem0use" => ["round-a-bout", "round-a-bout-old"],
      "Hog" => ["hedge", "manual-blast"],
      "Sunky" => ["milk-", "milk-old"],
      "Sanic" => ["2fest", "too-fest"],
      "Coldsteel" => ["personel"],
      "Requital" => ["forestall-desire"],
      "Genesys" => ["burning"],
      "Secret Histories Tails" => ["mania"],
      "Satanos" => ["perdition", "retaliation"],
      "No More Innocence" => ["fakebaby"],
      "SL4SH" => ["b4cksl4sh"],
      "EXE" => ["faker", "black-sun", "godspeed"],
      "OnMyWay.exe" => ["universal-collapse-v1"],
      "Christmas" => ["slaybells", "slaybells-majin-mix", "missiletoe"]
    ];

    public static var characters:Array<String> = [ // just for ordering
      "Xenophanes",
      "Xenophanes Part 2",
      "Xenophanes Part 3",
      "Majin Sonic",
      "Majin Sonic Part 2",
      "Lord X",
      "Lord X Part 2",
      "Tails Doll",
      "Fleetway Super Sonic",
      "Fatal Error",
      "Chaotix",
      "Curse",
      "Starved",
      "X-Terion",
      "Needlem0use",
      "Hog",
      "Sunky",
      "Sanic",
      "Coldsteel",
      "Requital",
      "Genesys",
      "Secret Histories Tails",
      "Satanos",
      "No More Innocence",
      "SL4SH",
      "EXE",
      "OnMyWay.exe",
      "Christmas"
    ];

    // TODO: maybe a character display names map? for the top left in FreeplayState

    public static var songToChar:Map<String,String>=[];

    public static function init(){ // can PROBABLY use a macro for this? but i have no clue how they work so lmao
      // trust me I tried
      // if shubs or smth wants to give it a shot then go ahead
      // - neb
      songToChar.clear();
      for(character in data.keys()){
        var songs = data.get(character);
        for(song in songs)songToChar.set(song,character);
      }
    }

    public static function getSongsByChar(char:String)
    {
      if(data.exists(char))return data.get(char);
      return [];
    }

    public static function isLastSong(song:String)
    {
        /*for (i in songs)
        {
            if (i[i.length - 1] == song) return true;
        }
        return false;*/
      if(!songToChar.exists(song))return true;
      var songList = getSongsByChar(songToChar.get(song));
      return songList[songList.length-1]==song;
    }
}
