package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.display.FPS;


class Main extends Sprite {

  function init () {
    // code
  }

  public function new () {
    super();
    addEventListener(Event.ADDED_TO_STAGE, added);
  }

  function added (e) {
    removeEventListener(Event.ADDED_TO_STAGE, added);
    init();
  }

  public static function main () {
    // static entry point
    Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
    Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
    Lib.current.addChild(new Main());
  }


}
