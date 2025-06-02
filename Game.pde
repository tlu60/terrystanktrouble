boolean gameStarted = false;
boolean gameEnded = false;
GameMap map;

void setup() {
  size(800, 600);
  map = new GameMap();
  textAlign(CENTER, CENTER);
  textSize(24);
}

void draw() {
  background(255);

  if (!gameStarted) {
    drawStartScreen();
  } else {
    map.draw(); // Draw the map and walls
    //add later
  }
}

void drawStartScreen() {
  fill(30,30,30);
  text("Terry's Tank Trouble", width / 2, height / 2 - 60);
  text("Player 1: WASD to move, 1 to shoot", width / 2, height / 2 - 20);
  text("Player 2: Arrow keys to move, P to shoot", width / 2, height / 2 + 20);
  text("Press SPACE to start", width / 2, height / 2 + 80);
}

  
void keyPressed() {
  if (!gameStarted && key == ' ') {
    gameStarted = true;
  }
  // Add tank controls here later
  
}
