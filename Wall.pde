
class Wall {
  PVector pos, size;

  Wall(PVector pos, PVector size) {
    this.pos = pos;
    this.size = size;
  }

  void draw() {
    fill(150);
    rect(pos.x, pos.y, size.x, size.y);
  }

  boolean contains(PVector p) {
    return p.x > pos.x && p.x < pos.x + size.x &&
           p.y > pos.y && p.y < pos.y + size.y;
  }
}
