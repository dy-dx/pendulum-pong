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

import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.common.math.B2Vec2;
import box2D.collision.B2AABB;
import box2D.collision.shapes.B2PolygonShape;

enum Player {
  Human;
  AI;
}

class Main extends Sprite {

  var world : B2World;
  var worldScale : Int;
  var groundBody : B2Body;

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
    var gravity = new B2Vec2(0, 10.0);
    world = new B2World(gravity, true);
    worldScale = 100;
    var ws = worldScale;

    /*** Ground Box ***/

    var groundBodyDef = new B2BodyDef();
    groundBodyDef.position.set(400.0/ws, 610.0/ws);
    var groundShapeDef = new B2PolygonShape();
    groundShapeDef.setAsBox(400/ws, 10/ws);
    var groundFixture = new B2FixtureDef();
    groundFixture.shape = groundShapeDef;
    var groundBody = world.createBody(groundBodyDef);
    groundBody.createFixture(groundFixture);

    /*** Ceiling Box ***/

    var ceilingBodyDef = new B2BodyDef();
    ceilingBodyDef.position.set(400.0/ws, -10.0/ws);
    var ceilingShapeDef = new B2PolygonShape();
    ceilingShapeDef.setAsBox(400/ws, 10/ws);
    var ceilingFixture = new B2FixtureDef();
    ceilingFixture.shape = ceilingShapeDef;
    var ceilingBody = world.createBody(ceilingBodyDef);
    ceilingBody.createFixture(ceilingFixture);


    paddle1 = new Paddle(world, worldScale);
    paddle1.x = 35;
    paddle1.y = 250;

    paddle2 = new Paddle(world, worldScale);
    paddle2.x = 750;
    paddle2.y = 250;

    ball = new Ball(world, worldScale);

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
    // messageField.text = "Press SPACE to start\nUse ARROW KEYS to move your platform";

    scorePlayer = 0;
    scoreAI = 0;

    startRound();

    // game loop
    this.addEventListener(Event.ENTER_FRAME, update);
  }

  function update (e:Event) : Void {
    if (arrowKeyUp) { paddle1.y -= paddle1.speed; }
    if (arrowKeyDown) { paddle1.y += paddle1.speed; }

    var timeStep = 1.0/60.0;
    var velocityIterations = 8;
    var positionIterations = 3;
    world.step(timeStep, velocityIterations, positionIterations);

    paddle1.update();
    paddle2.update();
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
    ball.setStartingPosition(400, 300);
    ball.setRandomAngle();
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
    addChild(new FPS(10, 10, 0xFFFFFF));
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
