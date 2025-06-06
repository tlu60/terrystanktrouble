class Tank {
  PVector pos;
  PVector vel;
  PVector acc;
  PVector dir;

  float maxSpeed = 3;
  float accelRate = 0.4;
  float friction = 0.9;

  int ammo = 3;
  int maxAmmo = 3;
  int reloadTime = 60;
  int reloadCounter = 0;

  float size = 30;
  int tankColor;
  int health = 3;

  Tank(PVector startPos, int tankColor) {
    this.pos = startPos.copy();
    this.vel = new PVector(0, 0);
    this.acc = new PVector(0, 0);
    this.dir = new PVector(1, 0); // Default facing
    this.tankColor = tankColor;
  }

  void update() {
    handleMovement();
    reload();
  }

  void handleMovement() {
    acc.set(0, 0); // Reset acceleration

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

    // Clamp to max speed
    if (vel.mag() > maxSpeed) {
      vel.setMag(maxSpeed);
    }

    if (vel.mag() > 0.1) {
      dir = vel.copy().normalize(); // Update facing direction
    }

    pos.add(vel);
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
    return new Bullet(bulletStart, dir.copy(), tankColor, this);
  }

  void draw() {
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(dir.heading());
    fill(tankColor);
    rectMode(CENTER);
    rect(0, 0, size, size);
    fill(255);
    rect(size / 2, 0, size / 2, 5); // cannon
    popMatrix();
  }
}
