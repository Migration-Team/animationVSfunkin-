import flixel.FlxG;
import flixel.FlxSprite;
#if VIDEOS_ALLOWED
#if (hxCodec >= "2.6.1") 
import hxcodec.VideoHandler as MP4Handler;
#elseif (hxCodec == "2.6.0") 
import VideoHandler as MP4Handler;
#else 
import vlc.MP4Handler;
#end
#end
class CutsceneState extends MusicBeatState
{
	public var video:MP4Handler;

	public var path:String = "";

	public function new(bruh)
	{
		path = bruh;
		super();
	}

	public function load()
	{
		video = new MP4Handler();
	}

	public override function update(elapsed)
	{
		if (FlxG.keys.justPressed.ENTER)
		{
			//video.kill(); // provavelmente vai dar erro mas tá 
			MusicBeatState.switchState(new PlayState());
		}
		super.update(elapsed);
	}

	public override function create()
	{
		video.playVideo(Paths.video(path));
		video.finishCallback = function()
		{
			MusicBeatState.switchState(new PlayState());
		};
		super.create();
	}
}
