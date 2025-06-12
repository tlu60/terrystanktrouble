class PowerUp {
  PVector pos;
  PowerUpType type;
  float duration = 10 * 60; // 10 seconds
  boolean isActive = true;

  PowerUp(PVector pos, PowerUpType type) {
    this.pos = pos;
    this.type = type;
  }

  void apply(Tank t) {
    // Implementation based on power up type
  }

  void update() {
    duration--;
    if (duration <= 0) isActive = false;
  }

  void draw() {
    if (!isActive) return;
    fill(0, 255, 255);
    ellipse(pos.x, pos.y, 15, 15);
  }
}
