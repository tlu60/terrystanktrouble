class GameMap {
  ArrayList<Wall> walls;

  GameMap() {
    walls = new ArrayList<Wall>();

    float thin = 20;
    float longH = 150;
    float shortH = 80;
    float gap = 100;

    float cx = width / 2;
    float cy = height / 2;

    // Perimeter walls
    walls.add(new Wall(0, thin / 2, width * 2, thin));
    walls.add(new Wall(0, height - thin / 2, width * 2, thin));
    walls.add(new Wall(thin / 2, 0, thin, height * 2));
    walls.add(new Wall(width - thin / 2, 0, thin, height * 2));

    // Central vertical corridor
    walls.add(new Wall(cx, cy - gap, thin, longH));
    walls.add(new Wall(cx, cy + gap, thin, longH));

    // Horizontal T walls left and right
    walls.add(new Wall(cx - 150, cy - gap, 100, thin));
    walls.add(new Wall(cx + 150, cy + gap, 100, thin));

    // Middle horizontal line
    walls.add(new Wall(cx, cy, 200, thin));

    // Side blocks - symmetrical
    walls.add(new Wall(cx - 300, cy - 200, thin, shortH));
    walls.add(new Wall(cx + 300, cy - 200, thin, shortH));
    walls.add(new Wall(cx - 300, cy + 200, thin, shortH));
    walls.add(new Wall(cx + 300, cy + 200, thin, shortH));

    // Additional side walls for interesting movement
    walls.add(new Wall(cx - 200, cy, 100, thin));
    walls.add(new Wall(cx + 200, cy, 100, thin));
    walls.add(new Wall(cx - 100, cy + 150, thin, 100));
    walls.add(new Wall(cx + 100, cy - 150, thin, 100));
  }

  void draw() {
    for (Wall wall : walls) {
      wall.draw();
    }
  }

  boolean collidesWithWalls(float x, float y, float w, float h) {
    for (Wall wall : walls) {
      if (wall.collides(x, y, w, h)) {
        return true;
      }
    }
    return false;
  }
}
