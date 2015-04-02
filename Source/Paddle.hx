package;

import openfl.display.Sprite;


class Paddle extends Sprite {

  public var speed : Int;

  public function new () {
    super();

    speed = 7;
    y = 250;

    this.graphics.beginFill(0xFFFFFF);
    this.graphics.drawRect(0, 0, 15, 100);
    this.graphics.endFill();
  }

  public function update () : Void {
    if (y < 5) { y = 5; }
    if (y > 495) { y = 495; }
  }
}
