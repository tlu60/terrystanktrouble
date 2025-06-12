class Bullet {
  PVector pos, vel;
  Tank shooter;
  int bounceCount = 0;
  int maxBounces = 2;
  float radius = 5;

  Bullet(PVector pos, PVector vel, Tank shooter) {
    this.pos = pos.copy();
    this.vel = vel.copy();
    this.shooter = shooter;
  }

  void update() {
    PVector nextPos = PVector.add(pos, vel);
    boolean bounced = false;

    for (Wall wall : map.walls) {
      if (wall.collides(nextPos, radius)) {
        // Reflect bullet direction
        float prevX = pos.x, prevY = pos.y;
        pos.add(vel);

        if (wall.collides(new PVector(prevX + vel.x, pos.y), radius)) {
          vel.x *= -1;
          bounced = true;
        }
        if (wall.collides(new PVector(pos.x, prevY + vel.y), radius)) {
          vel.y *= -1;
          bounced = true;
        }

        if (bounced) bounceCount++;
        return;
      }
    }

    pos.add(vel);
    draw();
  }

  void draw() {
    fill(255, 255, 0);
    noStroke();
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }

  boolean checkCollision(Tank t) {
    if (shooter == t || t.isDead()) return false;
    return PVector.dist(pos, t.pos) < t.radius;
  }

  boolean isOutOfBounds() {
    return pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height || bounceCount > maxBounces;
  }
}
