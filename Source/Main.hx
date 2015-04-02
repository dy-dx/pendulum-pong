package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.display.FPS;


class Main extends Sprite {

  var paddle1 : Paddle;
  var paddle2 : Paddle;
  var ball : Ball;

  function init () {
    paddle1 = new Paddle();
    paddle1.x = 35;
    paddle1.y = 250;

    paddle2 = new Paddle();
    paddle2.x = 750;
    paddle2.y = 250;

    ball = new Ball();
    ball.x = 400;
    ball.y = 300;

    addChild(paddle1);
    addChild(paddle2);
    addChild(ball);
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
