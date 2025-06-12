class Tank {
  PVector pos, vel;
  float angle;
  float maxSpeed = 3;
  float acceleration = 0.2;
  float friction = 0.05;
  float radius = 20;

  int ammo = 3;
  int maxAmmo = 3;
  int health = 3;
  int reloadCounter = 0;
  int reloadDelay = 60;

  int col;
  GameMap map;

  Tank(float x, float y, int col, GameMap map) {
    this.pos = new PVector(x, y);
    this.vel = new PVector();
    this.col = col;
    this.map = map;
  }

  void handleMovement() {
    PVector input = new PVector();
    if (this == player1) {
      if (wPressed) input.y -= 1;
      if (sPressed) input.y += 1;
      if (aPressed) input.x -= 1;
      if (dPressed) input.x += 1;
    } else {
      if (upPressed) input.y -= 1;
      if (downPressed) input.y += 1;
      if (leftPressed) input.x -= 1;
      if (rightPressed) input.x += 1;
    }

    if (input.magSq() > 0) {
      input.normalize().mult(acceleration);
      vel.add(input);
      angle = atan2(input.y, input.x);
    }

    vel.mult(1 - friction);
    vel.limit(maxSpeed);

    PVector nextPos = PVector.add(pos, vel);
    if (!map.collidesWithWall(nextPos, radius)) {
      pos.set(nextPos);
    }

    reload();
  }

  void update() {
    drawTank();
  }

  void drawTank() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    fill(col);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, radius * 2, radius * 2);
    rect(radius / 2, -5, 15, 10);  // cannon
    popMatrix();
  }

  Bullet shoot() {
    if (ammo > 0) {
      ammo--;
      PVector dir = PVector.fromAngle(angle).mult(5);
      return new Bullet(pos.copy(), dir, this);
    }
    return null;
  }

  boolean canShoot() {
    return ammo > 0;
  }

  void reload() {
    if (ammo < maxAmmo) {
      reloadCounter++;
      if (reloadCounter >= reloadDelay) {
        ammo++;
        reloadCounter = 0;
      }
    }
  }

  void takeDamage() {
    health--;
  }

  boolean isDead() {
    return health <= 0;
  }
}
