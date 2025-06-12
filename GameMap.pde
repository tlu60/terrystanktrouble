class GameMap {
  ArrayList<Wall> walls;

  GameMap() {
    walls = new ArrayList<Wall>();
    generateWalls();
  }

  void generateWalls() {
    float thickness = 20;

    // Outer perimeter
    walls.add(new Wall(0, 0, width, thickness));
    walls.add(new Wall(0, height - thickness, width, thickness));
    walls.add(new Wall(0, 0, thickness, height));
    walls.add(new Wall(width - thickness, 0, thickness, height));

    // Inner symmetrical walls
    float w = 100;
    float h = 20;
    walls.add(new Wall(width/2 - w/2, height/2 - 100, w, h));
    walls.add(new Wall(width/2 - w/2, height/2 + 100, w, h));
    walls.add(new Wall(width/2 - 200, height/2 - h/2, h, w));
    walls.add(new Wall(width/2 + 200 - h, height/2 - h/2, h, w));
  }

  void draw() {
    for (Wall wall : walls) {
      wall.draw();
    }
  }

  boolean collidesWithWall(PVector pos, float radius) {
    for (Wall wall : walls) {
      if (wall.collides(pos, radius)) {
        return true;
      }
    }
    return false;
  }
}
