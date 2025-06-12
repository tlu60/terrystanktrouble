class Wall {
  float x, y, w, h;

  Wall(float x_, float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
  }

  void draw() {
    fill(150);
    noStroke();
    rectMode(CORNER); // Use top-left corner
    rect(x, y, w, h);
  }

  boolean collides(float tx, float ty, float tw, float th) {
    return tx + tw > x && tx < x + w &&
           ty + th > y && ty < y + h;
  }
}
