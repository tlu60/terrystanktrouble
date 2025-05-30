class PowerUp {
  PowerUpType type;
  float duration = 10.0;
  float activeTime;
  boolean isActive;

  PowerUp(PowerUpType type) {
    this.type = type;
    this.activeTime = 0;
    this.isActive = false;
  }

  void apply(Tank tank) {
    // Apply the effect based on type
    switch(type) {
      case FASTER:
        tank.speed += 1;
        break;
      case EXTRA_BOUNCE:
        tank.ammo += 1;
        break;
      // Add other cases
    }
    isActive = true;
  }

  void update() {
    if (isActive) {
      activeTime += 1 / frameRate;
      if (activeTime > duration) {
        isActive = false;
        // Optionally remove effect from tank
      }
    }
  }
}
