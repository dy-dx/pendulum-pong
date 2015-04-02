package;

import openfl.display.Sprite;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import openfl.display.FPS;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.TextFieldAutoSize;

enum Player {
  Human;
  AI;
}

class Main extends Sprite {

  var paddle1 : Paddle;
  var paddle2 : Paddle;
  var ball : Ball;

  var scorePlayer : Int;
  var scoreAI : Int;
  var scoreField : TextField;
  var messageField : TextField;

  var arrowKeyUp : Bool;
  var arrowKeyDown : Bool;

  function init () {
    paddle1 = new Paddle();
    paddle1.x = 35;
    paddle1.y = 250;

    paddle2 = new Paddle();
    paddle2.x = 750;
    paddle2.y = 250;

    ball = new Ball();

    addChild(paddle1);
    addChild(paddle2);
    addChild(ball);

    // controls
    stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
    stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
    arrowKeyUp = false;
    arrowKeyDown = false;

    // score display
    var scoreFormat = new TextFormat("Verdana", 24, 0xBBBBBB, true);
    scoreFormat.align = TextFormatAlign.CENTER;
    scoreField = new TextField();
    addChild(scoreField);
    scoreField.width = 800;
    scoreField.y = 30;
    scoreField.defaultTextFormat = scoreFormat;
    scoreField.selectable = false;

    var messageFormat:TextFormat = new TextFormat("Verdana", 18, 0xBBBBBB, true);
    messageFormat.align = TextFormatAlign.CENTER;

    messageField = new TextField();
    addChild(messageField);
    messageField.width = 800;
    messageField.y = 530;
    messageField.defaultTextFormat = messageFormat;
    messageField.selectable = false;
    messageField.text = "Press SPACE to start\nUse ARROW KEYS to move your platform";

    scorePlayer = 0;
    scoreAI = 0;

    startRound();

    // game loop
    this.addEventListener(Event.ENTER_FRAME, update);
  }

  function update (e:Event) : Void {
    if (arrowKeyUp) { paddle1.y -= paddle1.speed; }
    if (arrowKeyDown) { paddle1.y += paddle1.speed; }

    paddle1.update();
    ball.update();

    if (ball.x < 5) { winGame(AI); }
    if (ball.x > 795) { winGame(Human); }
  }

  function winGame (player:Player) : Void {
    if (player == Human) {
      scorePlayer++;
    } else {
      scoreAI++;
    }
    startRound();
  }

  function startRound () : Void {
    updateScore();
    ball.x = 400;
    ball.y = 300;
    var randomAngle:Float = Math.random() * 2 * Math.PI;
    ball.movement.x = Math.cos(randomAngle) * ball.speed;
    ball.movement.y = Math.sin(randomAngle) * ball.speed;
  }

  function keyDown (e:KeyboardEvent) : Void {
    if (e.keyCode == 38) {
      arrowKeyUp = true;
    } else if (e.keyCode == 40) {
      arrowKeyDown = true;
    }
  }

  function keyUp (e:KeyboardEvent) : Void {
    if (e.keyCode == 38) {
      arrowKeyUp = false;
    } else if (e.keyCode == 40) {
      arrowKeyDown = false;
    }
  }

  function updateScore () : Void {
    scoreField.text = scorePlayer + ":" + scoreAI;
  }

  public function new () {
    super();
    addEventListener(Event.ADDED_TO_STAGE, added);
  }

  function added (e:Event) : Void {
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
