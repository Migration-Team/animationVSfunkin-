package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.util.FlxSave;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var warnText:FlxText;
	override function create()
	{
		super.create();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(bg);

		#if android
		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out!\n
			Be careful when you touch the phone fast!\n
			You can break your phone screen if you do that,also\n
			This Mod contains some flashing lights!\n
			Press A to disable them now or go to Options Menu.\n
			Press B to ignore this message.\n
			You've been warned!",
			32);
		#else
		warnText = new FlxText(0, 0, FlxG.width,
			"Hey, watch out!\n
			This Mod contains some flashing lights!\n
			Press ENTER to disable them now or go to Options Menu.\n
			Press ESCAPE to ignore this message.\n
			You've been warned!",
			32);
		#end
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		add(warnText);

		#if android
                addVirtualPad(NONE, A_B);
                #end
	}
	
	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ENTER #if android || _virtualpad.buttonA.justPressed #end) {
			var save:FlxSave = new FlxSave();
			save.bind('avfnf', 'ninjamuffin99');
			save.data.flashinglol = true;
			save.flush();
			FlxG.log.add("Settings saved!");
            FlxG.switchState(new TitleState());
			ClientPrefs.flashing = true;
			ClientPrefs.saveSettings();
			FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxTween.tween(warnText, {alpha: 0}, 1, {
            });
		} else if (FlxG.keys.justPressed.ESCAPE #if android || _virtualpad.buttonB.justPressed #end) {
			var save:FlxSave = new FlxSave();
			save.bind('avfnf', 'ninjamuffin99');
			save.data.flashinglol = true;
			save.flush();
			FlxG.log.add("Settings saved!");
            FlxG.switchState(new TitleState());
			ClientPrefs.flashing = false;
			ClientPrefs.saveSettings();
            FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxTween.tween(warnText, {alpha: 0}, 1, {
            });
		}

		super.update(elapsed);
   }
}
