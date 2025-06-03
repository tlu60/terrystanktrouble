class Bullet {
  PVector pos;
  PVector vel;
  float speed = 6;
  float radius = 6;
  int bulletColor;

  Bullet(PVector startPos, PVector dir, int c) {
    pos = startPos.copy();
    vel = dir.copy().normalize().mult(speed);
    bulletColor = c;
  }

  void update() {
    pos.add(vel);
  }

  void draw() {
    fill(bulletColor);
    noStroke();
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }

  boolean hits(Tank t) {
    return dist(pos.x, pos.y, t.pos.x, t.pos.y) < t.size / 2;
  }

  boolean isOffScreen() {
    return pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height;
  }
}
