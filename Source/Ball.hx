package;

import openfl.display.Sprite;
import openfl.geom.Point;

import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2CircleShape;

class Ball extends Sprite {

  public var speed : Int;
  public var movement : Point;
  public var world : B2World;
  public var body : B2Body;
  var worldScale : Int;

  public function new (world:B2World, worldScale:Int) {
    super();

    // attributes
    speed = 7;
    movement = new Point(0, 0);

    // graphics
    this.graphics.beginFill(0xFFFFFF);
    this.graphics.drawCircle(0, 0, 10);
    this.graphics.endFill();

    this.world = world;
    this.worldScale = worldScale;
    makeBody();
  }

  public function update () : Void {
    var position = body.getPosition();
    x = position.x * worldScale;
    y = position.y * worldScale;
  }

  public function setStartingPosition (x:Float, y:Float) : Void {
    body.setPosition(new B2Vec2(x/worldScale, y/worldScale));
  }

  public function setRandomAngle () : Void {
    var randomAngle:Float = Math.random() * 2 * Math.PI;
    var xVelocity = Math.cos(randomAngle) * this.speed;
    var yVelocity = Math.sin(randomAngle) * this.speed;
    body.setAngle(randomAngle);
    body.setLinearVelocity(new B2Vec2(xVelocity, yVelocity));
  }

  function makeBody () : Void {
    var bodyDef = new B2BodyDef();
    bodyDef.type = DYNAMIC_BODY;

    var shapeDef = new B2CircleShape();
    shapeDef.setRadius(10.0 / worldScale);

    var fixtureDef = new B2FixtureDef();
    fixtureDef.shape = shapeDef;
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.0;

    fixtureDef.restitution = 1.0;

    body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
  }

}
