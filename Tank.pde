class Tank {
  PVector pos, vel, acc, dir;
  float maxSpeed = 3, accelRate = 0.4, friction = 0.9;
  int ammo = 3, maxAmmo = 3, reloadTime = 60, reloadCounter = 0;
  float size = 30;
  int tankColor;
  int health = 3;

  Tank(PVector startPos, int tankColor) {
    this.pos = startPos.copy();
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.dir = new PVector(1, 0);
    this.tankColor = tankColor;
  }

  void update() {
    handleMovement();
    reload();
  }

  void handleMovement() {
    acc.set(0, 0);

    if (this == player1) {
      if (keyPressed) {
        if (key == 'w') acc.y -= accelRate;
        if (key == 's') acc.y += accelRate;
        if (key == 'a') acc.x -= accelRate;
        if (key == 'd') acc.x += accelRate;
      }
    } else if (this == player2) {
      if (keyPressed) {
        if (keyCode == UP) acc.y -= accelRate;
        if (keyCode == DOWN) acc.y += accelRate;
        if (keyCode == LEFT) acc.x -= accelRate;
        if (keyCode == RIGHT) acc.x += accelRate;
      }
    }

    vel.add(acc);
    vel.mult(friction);

    if (vel.mag() > maxSpeed) {
      vel.setMag(maxSpeed);
    }

    if (vel.mag() > 0.1) {
      dir = vel.copy().normalize();
    }

    PVector nextPos = pos.copy().add(vel);
    if (!map.checkWallCollision(nextPos)) {
      pos = nextPos;
    } else {
      vel.mult(0); // stop movement if wall hit
    }
  }

  void reload() {
    if (ammo < maxAmmo) {
      reloadCounter++;
      if (reloadCounter >= reloadTime) {
        ammo++;
        reloadCounter = 0;
      }
    }
  }

  boolean canShoot() {
    return ammo > 0;
  }

  Bullet shoot() {
    ammo--;
    PVector bulletStart = pos.copy().add(dir.copy().mult(size / 2 + 6));
    return new Bullet(bulletStart, dir.copy().mult(5), tankColor, this);
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(dir.heading());
    fill(tankColor);
    rectMode(CENTER);
    rect(0, 0, size, size);
    fill(255);
    rect(size / 2, 0, size / 2, 5);
    popMatrix();
  }
}
