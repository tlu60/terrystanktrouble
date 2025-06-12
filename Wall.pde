class Wall {
  float x, y, w, h;

  Wall(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw() {
    fill(150);  // grey walls
    noStroke();
    rect(x, y, w, h);
  }

  boolean collides(PVector pos, float radius) {
    float closestX = constrain(pos.x, x, x + w);
    float closestY = constrain(pos.y, y, y + h);
    float dx = pos.x - closestX;
    float dy = pos.y - closestY;
    return dx * dx + dy * dy < radius * radius;
  }
}
