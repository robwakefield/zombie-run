
class Player {

  PVector pos, vel, target;
  float w = 30;
  float maxStep = 5;
  
  int health, speed, coins;

  Player(float startX, float startY) {
    pos = new PVector(startX, startY);
    target = new PVector(startX, startY);
    vel = new PVector(0, 0);
    health = 100;
    speed = 10;
    coins = 1234;
  }

  void show() {
    update();
    pushMatrix();
    rectMode(CENTER);
    fill(255);
    stroke(0);
    strokeWeight(2);
    square(pos.x, pos.y, w);
    popMatrix();
  }

  void moveTo(float x, float y) {
    if (x < width/8) {
      x = width/8 + w;
    } else if (x > 7 * width/8) {
      x = 7 * width/8 - w;
    }
    if (y < height/4) {
      y = height/4;
    } else if (y > 3 * height/4) {
      y = 3 * height/4;
    }
    target = new PVector(x, y);
  }

  void update() {
    float xDist = target.x - pos.x;
    float yDist = target.y - pos.y;
    float distance = sqrt(pow(xDist, 2) + pow(yDist, 2));
    float step = map(distance, 0, w * 5, 1, maxStep);
    float angle = atan2(yDist, xDist);
    pos.x += step * cos(angle);
    pos.y += step * sin(angle);
  }
  
  int upgradeCost(){
    return 50;
  }
}
