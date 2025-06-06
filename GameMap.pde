class GameMap {
  ArrayList<Wall> walls;
  int uiMargin = 70;

  GameMap() {
    walls = new ArrayList<Wall>();
    generateWalls();
  }

  void generateWalls() {
    walls.clear();

    // Border walls
    walls.add(new Wall(new PVector(0, uiMargin), new PVector(width, 10))); // top
    walls.add(new Wall(new PVector(0, height - 10), new PVector(width, 10))); // bottom
    walls.add(new Wall(new PVector(0, uiMargin), new PVector(10, height - uiMargin - 10))); // left
    walls.add(new Wall(new PVector(width - 10, uiMargin), new PVector(10, height - uiMargin - 10))); // right

    // Symmetrical interior walls
    walls.add(new Wall(new PVector(width/2 - 100, height/2 - 60), new PVector(200, 10)));
    walls.add(new Wall(new PVector(width/2 - 10, height/2 - 100), new PVector(10, 80)));
    walls.add(new Wall(new PVector(width/2 - 10, height/2 + 20), new PVector(10, 80)));
    walls.add(new Wall(new PVector(width/2 - 100, height/2 + 60), new PVector(200, 10)));
  }

  void draw() {
    for (Wall w : walls) {
      w.draw();
    }
  }

  boolean checkWallCollision(PVector pos) {
    for (Wall w : walls) {
      if (w.contains(pos)) return true;
    }
    return false;
  }
}
