package;

class CharSongList
{
    public static var data:Map<String,Array<String>> = [
      "xeno" => ["too-slow", "too-slow-encore", "you-cant-run", "you-cant-run-encore", "triple-trouble", "triple-trouble-encore-knuckles", "too-slow-old", "you-cant-run-old", "triple-trouble-old"],
      "majin" => ["endless", "endless-og", "endless-us", "endless-jp", "endless-encore", "endeavors"],
      "lord x" => ["cycles", "cycles-old", "fate", "hellbent", "gotta-go", "execution"],
      "tails doll" => ["sunshine-", "soulless"],
      "fleetway" => ["chaos"],
      "fatalerror" => ["fatality"],
      "chaotix" => ["my-horizon", "our-horizon"],
      "curse" => ["malediction"],
      "starved" => ["prey", "fight-or-flight"],
      "xterion" => ["substantial", "digitalized"],
      "needlemouse" => ["round-a-bout", "round-a-bout-old"],
      "hog" => ["hedge", "manual-blast"],
      "sunky" => ["milk-", "milk-old"],
      "sanic" => ["2fest", "too-fest"],
      "coldsteel" => ["personel"],
      "requital" => ["forestall-desire"],
      "genesys" => ["burning"],
      "secret histories tails" => ["mania"],
      "satanos" => ["perdition", "retaliation"],
      "no more innocence" => ["fakebaby"],
      "sl4sh" => ["b4cksl4sh"],
      "exe" => ["faker", "black-sun", "godspeed"],
      "onmyway.exe" => ["universal-collapse-v1"],
      "christmas" => ["slaybells", "slaybells-majin-mix", "missiletoe"]
    ];

    public static var characters:Array<String> = [ // just for ordering
      "xeno",
      "majin",
      "lord x",
      "tails doll",
      "fleetway",
      "fatalerror",
      "chaotix",
      "curse",
      "starved",
      "xterion",
      "needlemouse",
      "hog",
      "sunky",
      "sanic",
      "coldsteel",
      "requital",
      "genesys",
      "secret histories tails",
      "satanos",
      "no more innocence",
      "sl4sh",
      "exe",
      "onmyway.exe",
      "christmas"
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
