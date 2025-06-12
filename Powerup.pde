class PowerUp {
  float x, y;
  float size = 30;
  PowerUpType type;
  GameMap map;

  PowerUp(GameMap map_) {
    map = map_;
    PowerUpType[] types = PowerUpType.values();
    type = types[(int)random(types.length)];
    do {
      x = random(size, width - size);
      y = random(size, height - size);
    } while (map.collidesWithWalls(x - size/2, y - size/2, size, size));
  }

  boolean checkCollision(Tank t) {
    return !(x + size/2 < t.x - t.width/2 || x - size/2 > t.x + t.width/2 ||
             y + size/2 < t.y - t.height/2 || y - size/2 > t.y + t.height/2);
  }

  void draw() {
    switch(type) {
      case FAST_RELOAD: fill(0, 255, 0); break;
      case BOUNCING_BULLETS: fill(0, 0, 255); break;
      case BIGGER_BULLETS: fill(255, 165, 0); break;
      case SMALLER_SIZE: fill(255, 0, 255); break;
      case FAST_MOVEMENT_SPEED: fill(255, 255, 0); break;
    }
    noStroke();
    ellipse(x, y, size, size);
  }
}
