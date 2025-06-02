class GameMap {
  ArrayList<Wall> walls;

  GameMap() {
    walls = new ArrayList<Wall>();
    loadMap();
  }

  void loadMap() {
    float thickness = 20;

    
    walls.add(new Wall(new PVector(0, 0), new PVector(width, thickness), false)); // Top
    walls.add(new Wall(new PVector(0, height - thickness), new PVector(width, thickness), false)); // Bottom
    walls.add(new Wall(new PVector(0, 0), new PVector(thickness, height), false)); // Left
    walls.add(new Wall(new PVector(width - thickness, 0), new PVector(thickness, height), false)); // Right

    // Optional inner walls (some destructible as an example)
    walls.add(new Wall(new PVector(300, 200), new PVector(20, 200), true));
    walls.add(new Wall(new PVector(400, 400), new PVector(100, 20), true));
    walls.add(new Wall(new PVector(500, 200), new PVector(20, 200), true));
    walls.add(new Wall(new PVector(400, 600), new PVector(100, 20), true));
  }

  void draw() {
    for (Wall w : walls) {
      w.draw();
    }
  }
}
