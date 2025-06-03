class Tank {
  PVector pos;
  PVector dir;
  float speed = 2.5;
  int ammo = 3;
  int maxAmmo = 3;
  int reloadTime = 60; // frames
  int reloadCounter = 0;
  float size = 30;
  int tankColor;

  Tank(PVector startPos, int tankColor) {
    this.pos = startPos.copy();
    this.dir = new PVector(1, 0);
    this.tankColor = tankColor;
  }

  void update() {
    move();
    reload();
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

  void move() {
    boolean moved = false;
    PVector newDir = new PVector();

    if (this == player1) {
      if (keyPressed) {
        if (key == 'w') { newDir.set(0, -1); moved = true; }
        if (key == 's') { newDir.set(0, 1); moved = true; }
        if (key == 'a') { newDir.set(-1, 0); moved = true; }
        if (key == 'd') { newDir.set(1, 0); moved = true; }
      }
    } else if (this == player2) {
      if (keyPressed) {
        if (keyCode == UP) { newDir.set(0, -1); moved = true; }
        if (keyCode == DOWN) { newDir.set(0, 1); moved = true; }
        if (keyCode == LEFT) { newDir.set(-1, 0); moved = true; }
        if (keyCode == RIGHT) { newDir.set(1, 0); moved = true; }
      }
    }

    if (moved) {
      dir = newDir.copy();
      dir.normalize();
      pos.add(PVector.mult(dir, speed));
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
    return new Bullet(pos.copy(), dir.copy(), tankColor);
  }
}

