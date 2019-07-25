

class Enemy {

  PVector pos, vel, target;
  float w = 30;
  float maxStep;

  Enemy(int level) {
    float startX = random(4*width/8)+2*width/8;
    float startY = random(-w*4);
    pos = new PVector(startX, startY);
    getNewTarget();
    vel = new PVector(0, 0);
    maxStep = map(level, 0, 5, 5, 9);
  }

  void show() {
    move();
    pushMatrix();
    rectMode(CENTER);
    fill(10, 140, 40);
    stroke(0);
    strokeWeight(2);
    square(pos.x, pos.y, w);
    popMatrix();
  }

  void update() {
    move();
  }

  // find a new random target
  void getNewTarget() {
    float x = pos.x + random(4*width/8) - 2*width/8;
    float y = pos.y + random(2*height/4) + height/4;
    setTarget(x, y);
  }

  // set the target to seek
  void setTarget(float x, float y) {
    if (x < width/8) {
      x = width/8 + w;
    } else if (x > 7 * width/8) {
      x = 7 * width/8 - w;
    }
    //if (y < height/4) {
    //  y = height/4;
    //} else if (y > 3 * height/4) {
    //  y = 3 * height/4;
    //}
    target = new PVector(x, y);
  }

  // move towards the target
  void move() {
    // get distance from current target
    float xDist = target.x - pos.x;
    float yDist = target.y - pos.y;
    float distance = sqrt(pow(xDist, 2) + pow(yDist, 2));
    // move set speed in that direction
    float step = 2;
    if (step >= distance) {
      // make sure bot does not overrun
      step = distance;
      getNewTarget();
    }
    // get angle to target
    float angle = atan2(yDist, xDist);
    // move the required amounts in x, y coordinate space
    pos.x += step * cos(angle);
    pos.y += step * sin(angle);
  }

  //void find(Player p) {
  //  float xDist = p.pos.x - pos.x;
  //  float yDist = p.pos.y - pos.y;
  //  float distance = sqrt(pow(xDist, 2) + pow(yDist, 2));
  //  if (distance > w * 0.5 && abs(xDist) < w * 5) {
  //    predict(p);
  //  } else if (target.y < height && target.y > pos.y) {
  //    target = new PVector(random(7*width/8)+width/8, height);
  //  }
  //}

  //void predict(Player p) {
  //  target = new PVector(p.pos.x + p.vel.x, p.pos.y + p.vel.y);
  //}

  boolean contains(Enemy[] enemies) {
    for (int i = 0; i < enemies.length; i++) {
      Enemy e = enemies[i];
      float xDist = e.pos.x - pos.x;
      float yDist = e.pos.y - pos.y;
      float distance = sqrt(pow(xDist, 2) + pow(yDist, 2));
      if (distance < w && e != this) {
        return true;
      }
    }
    return false;
  }

  //void update(Enemy[] enemies) {
  //  float xDist = target.x - pos.x;
  //  float yDist = target.y - pos.y;
  //  float distance = sqrt(pow(xDist, 2) + pow(yDist, 2));
  //  float step = map(distance, 0, w * 5, 1, maxStep);
  //  float angle = atan2(yDist, xDist);
  //  if (!contains(enemies)) {
  //    pos.x += step * cos(angle);
  //  } else {
  //    pos.x -= step * cos(angle);
  //  }
  //  pos.y += min(maxStep, abs(step * sin(angle)) + 4);
  //}
}
