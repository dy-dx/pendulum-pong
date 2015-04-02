package;

import openfl.display.Sprite;
import openfl.geom.Point;

class Ball extends Sprite {

  public var speed : Int;
  public var movement : Point;

  var minBoundY : Int = 5;
  var maxBoundY : Int = 595;

  public function new () {
    super();

    // attributes
    speed = 7;
    movement = new Point(0, 0);

    // graphics
    this.graphics.beginFill(0xFFFFFF);
    this.graphics.drawCircle(0, 0, 10);
    this.graphics.endFill();
  }

  public function update () : Void {
    x += movement.x;
    y += movement.y;

    if (y < minBoundY || y > maxBoundY) {
      movement.y *= -1;
    }
  }

}
