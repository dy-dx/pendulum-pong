package;

import openfl.display.Sprite;

import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2BodyDef;
import box2D.dynamics.B2FixtureDef;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

class Paddle extends Sprite {

  public var speed : Int;
  public var world : B2World;
  public var body : B2Body;
  var worldScale : Int;

  public function new (world:B2World, worldScale:Int) {
    super();

    speed = 7;
    y = 250;

    this.graphics.beginFill(0xFFFFFF);
    this.graphics.drawRect(0, 0, 15, 100);
    this.graphics.endFill();

    this.world = world;
    this.worldScale = worldScale;
    makeBody();
  }

  public function update () : Void {
    if (y < 5) { y = 5; }
    if (y > 495) { y = 495; }

    var scaledPosition = new B2Vec2( (x + width/2)/worldScale, (y + height/2)/worldScale );
    body.setPosition(scaledPosition);
  }

  function makeBody () : Void {
    var ws = worldScale;
    var bodyDef = new B2BodyDef();
    bodyDef.position.set((x + width/2)/ws, (y + height/2)/ws);

    var shapeDef = new B2PolygonShape();
    shapeDef.setAsBox(width/2/ws, height/2/ws);

    var fixtureDef = new B2FixtureDef();
    fixtureDef.shape = shapeDef;
    fixtureDef.density = 1.0;
    fixtureDef.friction = 0.0;

    body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
  }
}
