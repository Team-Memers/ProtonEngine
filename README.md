# Friday Night Funkin
[![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2FTheDrawingCoder-Gamer%2FFunkin%2Fbadge%3Fref%3Dmaster&style=for-the-badge)](https://actions-badge.atrox.dev/TheDrawingCoder-Gamer/Funkin/goto?ref=master)
![Azure DevOps builds](https://img.shields.io/azure-devops/build/benharless820/7af207e5-72fd-483f-9a48-6fc65e63abb9/4?label=pipelines&style=for-the-badge)
[![forthebadge](https://forthebadge.com/images/badges/fuck-it-ship-it.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/works-on-my-machine.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/contains-tasty-spaghetti-code.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/it-works-why.svg)](https://forthebadge.com)
[![forthebadge](https://forthebadge.com/images/badges/just-plain-nasty.svg)](https://forthebadge.com)

Once again, this is a fork of The Roblox Disappointment M+ build, with a few changes by me and Vixtin.

Some of the stuff you'll see here is from Sonic.exe (WeedVision, FatalPopup, CharSongList, and a lot of the transition stuff), Wednesday's Infidelity (WindowsData.hx),
and Yoshi Engine (WindowsAPI)

There is also DuskieWhy's FlxTransWindow and MultiWindow stuff

YOU WILL NEED TO INSTALL EVERYTHING RELATED TO EXTENSION-WEBM!!!


CHANGES FROM ORIGINAL M+/ROBLOX BUILD:

Fully custom playable character vocals (format is songnamecharactername_Voices)

Reverted back to music folder

Fully custom countdowns for stuff like Indie Cross

Sonic.exe Sound Test (Completely custom)

Mario's Madness Warp Zone (DEPRECATED)

Dave and Bambi Character Select Screen (old one is still in modifier menu)

Video support!! `currentPlayState.startVideo(video-name)` MP4 ONLY

MP4Handler has support too, so you can play videos on FlxSprites

FlxGlitchEffect, FlxWaveEffect, FlxRainbowEffect support

Shader support from VixtinEngine, you can use .frag files or the built-in shaders

Custom menu support also from VixtinEngine, you can customize CreditsState, FreeplayState, GameOverSubstate, MainMenuState, PauseSubstate, SaveDataState, SoundTestState, StoryMenuState, and TitleState

CoolUtil, LoadingState, FlxTypedGroup, FlxTypedSpriteGroup, FileSystem, File, WindowsAPI (Yoshi Engine), FlxFlicker, Main, FlxBar, FlxMouse, FlxMouseEventManger, and Sys are now available for use in modcharts

FlxBackdrop is also now available for use, make sure to use FNFAssets to load your image!

Health icon next to character in OldCharState (from VixtinEngine)

Probably more stuff that i forgot about


SOON TO COME:

Healthbar in custom_ui
Proper support for setting healthbar colors from the custom_chars jsonc
Character ui skins


- Get the cutting edge build: https://dev.azure.com/benharless820/FNF%20Modding%20Plus/_build
- Play the Original Game: https://github.com/ninjamuffin99/Funkin
- Need Help? FNF Modding Plus Discord: https://discord.gg/xeC748FR
- Trello Page (todo list): https://trello.com/b/cFjJJIjF/fnf-modding-plus
## Credits for the Original Game

- [ninjamuffin99](https://twitter.com/ninja_muffin99) - Programmer
- [PhantomArcade3K](https://twitter.com/phantomarcade3k) and [Evilsk8r](https://twitter.com/evilsk8r) - Art
- [KawaiSprite](https://twitter.com/kawaisprite) - Musician
## Modding+ Credits

- [BulbyVR](https://github.com/TheDrawingCoder-Gamer) - Owner/Programmer
- [DJ Popsicle](https://gamebanana.com/members/1780306) - Co-Owner/Additional Programmer
- [Matheus L/Mlops](https://gamebanana.com/members/1767306), [AndreDoodles](https://gamebanana.com/members/1764840), riko, Raf, ElBartSinsoJaJa, and [plum](https://www.youtube.com/channel/UCXbiI4MJD9Y3FpjW61lG8ZQ) - Artist & Animation
- [ThePinkPhantom/JuliettePink](https://gamebanana.com/members/1892442) - Portrait Artist
- [Alex Director](https://gamebanana.com/members/1701629) - Icon Fixer
- [Drippy](https://github.com/TrafficKid) - GitHub Wikipedia
- [GwebDev](https://github.com/GrowtopiaFli) - Edited WebM code
- [Axy](https://github.com/timeless13GH) - Poggers help
## Build instructions

THESE INSTRUCTIONS ARE FOR COMPILING THE GAME'S SOURCE CODE!!!

IF YOU WANT TO JUST DOWNLOAD AND INSTALL AND PLAY THE GAME NORMALLY, GO TO GAMEBANANA TO DOWNLOAD THE GAME FOR PC!!

https://gamebanana.com/gamefiles/14264

IF YOU WANT TO COMPILE THE GAME YOURSELF, OR PLAY ON MAC OR LINUX, CONTINUE READING!!!

IF YOU MAKE A MOD AND DISTRIBUTE A MODIFIED / RECOMIPLED VERSION, YOU MUST OPEN SOURCE YOUR MOD AS WELL

### Installing shit

First you need to install Haxe and HaxeFlixel. I'm too lazy to write and keep updated with that setup (which is pretty simple).
The link to that is on the [HaxeFlixel website](https://haxeflixel.com/documentation/getting-started/)

Other installations you'd need is the additional libraries, a fully updated list will be in `Project.xml` in the project root, but here are the one's I'm using as of writing.

```
hscript
flixel-ui
tjson
json2object
uniontypes
hxcpp-debug-server
```

So for each of those type `haxelib install [library]` so shit like `haxelib install hscript`

You'll also need to install hscript-ex. Do this with

```
haxelib git hscript-ex https://github.com/ianharrigan/hscript-ex
```


### Compiling game


To run it from your desktop (Windows, Mac, Linux) it can be a bit more involved. For Linux, you only need to open a terminal in the project directory and run 'lime test linux -debug' and then run the executible file in export/release/linux/bin. For Windows, you need to install Visual Studio Community 2019. While installing VSC, don't click on any of the options to install workloads. Instead, go to the individual components tab and choose the following:
* MSVC v142 - VS 2019 C++ x64/x86 build tools
* Windows SDK (10.0.17763.0)
* C++ Profiling tools
* C++ CMake tools for windows
* C++ ATL for v142 build tools (x86 & x64)
* C++ MFC for v142 build tools (x86 & x64)
* C++/CLI support for v142 build tools (14.21)
* C++ Modules for v142 build tools (x64/x86)
* Clang Compiler for Windows
* Windows 10 SDK (10.0.17134.0)
* Windows 10 SDK (10.0.16299.0)
* MSVC v141 - VS 2017 C++ x64/x86 build tools
* MSVC v140 - VS 2015 C++ build tools (v14.00)

This will install about 22GB of crap, but once that is done you can open up a command line in the project's directory and run `lime test windows -debug`. Once that command finishes (it takes forever even on a higher end PC), you can run FNF from the .exe file under export\release\windows\bin
As for Mac, 'lime test mac -debug' should work, if not the internet surely has a guide on how to compile Haxe stuff for Mac.
### Additional guides

- [Command line basics](https://ninjamuffin99.newgrounds.com/news/post/1090480)
