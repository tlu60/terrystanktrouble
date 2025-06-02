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
