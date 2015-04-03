package;

import openfl.display.Sprite;
import openfl.geom.Point;

import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2CircleShape;
import box2D.dynamics.joints.B2DistanceJointDef;
import box2D.dynamics.joints.B2DistanceJoint;
import box2D.dynamics.joints.B2Joint;

class Ball extends Sprite {

  public var speed : Int;
  public var movement : Point;
  public var world : B2World;
  public var body : B2Body;
  var worldScale : Int;
  var joint : B2Joint;

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
    // var xVelocity = Math.cos(randomAngle) * this.speed;
    var xVelocity = -14;
    // var yVelocity = Math.sin(randomAngle) * this.speed;
    var yVelocity = 0.0;
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
    // fixtureDef.density = 2.0;
    fixtureDef.density = 6.0;
    fixtureDef.friction = 0.0;

    fixtureDef.restitution = 1.2;

    body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
  }

  public function makeJoint (body2:B2Body) : Void {
    if (joint != null) { throw "yo what"; }
    var jointDef = new B2DistanceJointDef();
    jointDef.initialize(this.body, body2, this.body.getPosition(), body2.getWorldCenter());
    jointDef.collideConnected = false;
    joint = world.createJoint(jointDef);
  }

  public function destroyJoint () : Void {
    if (joint == null) { return; }
    world.destroyJoint(joint);
    joint = null;
  }

}
