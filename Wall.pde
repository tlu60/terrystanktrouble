class Wall {
  PVector position;
  PVector size;
  boolean isDestructible;

  Wall(PVector position, PVector size, boolean isDestructible) {
    this.position = position;
    this.size = size;
    this.isDestructible = isDestructible;
  }

  void draw() {
    if (isDestructible) {
      fill(255, 0, 0); // Red for destructible
    } else {
      fill(100);       // Gray for solid walls
    }
    rect(position.x, position.y, size.x, size.y);
  }
}
