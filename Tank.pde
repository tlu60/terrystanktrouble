class Tank {
  float x, y;
  float width = 40;
  float height = 40;
  float angle = 0;
  color tankColor;
  GameMap map;

  int ammo = 3;
  int maxAmmo = 3;
  int reloadTime = 120;
  int reloadTimer = 0;
  int shootCooldown = 0;

  int health = 3;

  PowerUpType activePowerUp = null;
  int powerUpDuration = 0;

  float speed = 2;

  Tank(float x_, float y_, color c, GameMap m) {
    x = x_;
    y = y_;
    tankColor = c;
    map = m;
  }

  void update() {
    // Reload ammo
    if (reloadTimer > 0) reloadTimer--;
    if (ammo < maxAmmo && reloadTimer == 0) {
      ammo++;
      reloadTimer = getReloadTime();
    }

    // Powerup duration countdown
    if (powerUpDuration > 0) {
      powerUpDuration--;
      if (powerUpDuration == 0) {
        activePowerUp = null;
        width = 40;
        height = 40;
        speed = 2;
      }
    }

    if (shootCooldown > 0) shootCooldown--;
  }

  void handleMovement() {
    float dx = 0, dy = 0;
    if (this == player1) {
      if (wPressed) dy -= speed;
      if (sPressed) dy += speed;
      if (aPressed) dx -= speed;
      if (dPressed) dx += speed;
    } else if (this == player2) {
      if (upPressed) dy -= speed;
      if (downPressed) dy += speed;
      if (leftPressed) dx -= speed;
      if (rightPressed) dx += speed;
    }

    if (dx != 0 || dy != 0) {
      float nextX = x + dx;
      float nextY = y + dy;

      // Check wall collision
      if (!map.collidesWithWalls(nextX - width/2, nextY - height/2, width, height)) {
        // Check collision with other tank
        Tank other = (this == player1) ? player2 : player1;
        if (!checkTankCollision(nextX, nextY, other)) {
          x = nextX;
          y = nextY;
          angle = atan2(dy, dx);
        }
      }
    }
  }

  boolean checkTankCollision(float nx, float ny, Tank other) {
    // Simple AABB collision check
    float halfW = width/2;
    float halfH = height/2;
    float otherHalfW = other.width/2;
    float otherHalfH = other.height/2;
    return !(nx + halfW < other.x - otherHalfW ||
             nx - halfW > other.x + otherHalfW ||
             ny + halfH < other.y - otherHalfH ||
             ny - halfH > other.y + otherHalfH);
  }

  void draw() {
    pushMatrix();
    translate(x, y);
    rotate(angle);
    fill(tankColor);
    rectMode(CENTER);
    rect(0, 0, width, height);
    fill(0);
    rect(width/4, 0, width/2, height/5);
    popMatrix();
  }

  boolean canShoot() {
    return ammo > 0 && shootCooldown == 0;
  }

  Bullet shoot() {
    float bx = x + cos(angle) * width/2;
    float by = y + sin(angle) * height/2;
    ammo--;
    shootCooldown = 10;
    return new Bullet(bx, by, angle, this, tankColor, activePowerUp);
  }

  void setPowerUp(PowerUpType type) {
    activePowerUp = type;
    powerUpDuration = 600; // 10 seconds at 60 fps
    if (type == PowerUpType.SMALLER_SIZE) {
      width = 25;
      height = 25;
    } else if (type == PowerUpType.FAST_MOVEMENT_SPEED) {
      speed = 4;
    }
  }

  boolean isDead() {
    return health <= 0;
  }

  void takeDamage() {
    health--;
  }

  int getReloadTime() {
    return activePowerUp == PowerUpType.FAST_RELOAD ? 30 : 120;
  }
}
