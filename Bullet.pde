class Bullet {
  float x, y;
  float angle;
  float speed = 8;
  float radius = 5;
  Tank shooter;
  color bulletColor;
  PowerUpType shooterPowerUp;

  int bounces = 0;
  int maxBounces = 0;

  Bullet(float x_, float y_, float angle_, Tank shooter_, color bulletColor_, PowerUpType shooterPowerUp_) {
    x = x_;
    y = y_;
    angle = angle_;
    shooter = shooter_;
    bulletColor = bulletColor_;
    shooterPowerUp = shooterPowerUp_;

    // Set max bounces based on shooter's powerup
    maxBounces = (shooterPowerUp == PowerUpType.BOUNCING_BULLETS) ? 3 : 0;

    // Increase bullet size if powerup active
    if (shooterPowerUp == PowerUpType.BIGGER_BULLETS) {
      radius = 10;
    }
  }

  void update() {
    float dx = cos(angle) * speed;
    float dy = sin(angle) * speed;

    float nextX = x + dx;
    float nextY = y + dy;

    // Check collision with walls and bounce if needed
    if (map.collidesWithWalls(nextX - radius, nextY - radius, radius*2, radius*2)) {
      if (bounces < maxBounces) {
        bounce(dx, dy);
        bounces++;
      } else {
        // No more bounces allowed, bullet disappears
        x = -1000;  // Offscreen
        y = -1000;
        return;
      }
    } else {
      x = nextX;
      y = nextY;
    }
  }

  void bounce(float dx, float dy) {
    // Simple bounce logic: invert direction if hitting walls on X or Y axis
    // Check horizontal collision
    boolean horizontalCollision = map.collidesWithWalls(x + dx, y - radius, radius*2, radius*2) ||
                                  map.collidesWithWalls(x + dx, y + radius, radius*2, radius*2);
    // Check vertical collision
    boolean verticalCollision = map.collidesWithWalls(x - radius, y + dy, radius*2, radius*2) ||
                                map.collidesWithWalls(x + radius, y + dy, radius*2, radius*2);

    if (horizontalCollision) {
      angle = PI - angle;
    }
    if (verticalCollision) {
      angle = -angle;
    }
    angle = (angle + TWO_PI) % TWO_PI; // Normalize angle
  }

  void draw() {
    fill(bulletColor);
    noStroke();
    ellipse(x, y, radius*2, radius*2);
  }

  boolean checkCollision(Tank tank) {
    if (tank.isDead()) return false;
    float distX = abs(x - tank.x);
    float distY = abs(y - tank.y);
    if (distX > (tank.width/2 + radius)) return false;
    if (distY > (tank.height/2 + radius)) return false;

    // More precise check could be circle-rectangle collision:
    if (distX <= tank.width/2) return true;
    if (distY <= tank.height/2) return true;

    float dx = distX - tank.width/2;
    float dy = distY - tank.height/2;
    return (dx*dx + dy*dy <= radius*radius);
  }

  boolean isOutOfBounds() {
    return x < 0 || x > width || y < 0 || y > height;
  }
}
