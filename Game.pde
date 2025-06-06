Tank player1, player2;
GameMap map;
ArrayList<Bullet> bullets;

boolean gameStarted = false;
boolean gameOver = false;
String winner = "";

void setup() {
  size(800, 600);
  map = new GameMap();
  bullets = new ArrayList<Bullet>();
  player1 = new Tank(new PVector(100, 100), color(0, 150, 255));
  player2 = new Tank(new PVector(700, 500), color(255, 100, 0));
  textAlign(CENTER, CENTER);
  textSize(20);
}

void draw() {
  background(0);

  if (!gameStarted) {
    drawStartScreen();
  } else if (gameOver) {
    drawEndScreen();
  } else {
    map.draw();

    player1.update();
    player2.update();

    player1.draw();
    player2.draw();

    // Update bullets
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet b = bullets.get(i);
      b.update();
      b.draw();

      if (b.hits(player1)) {
        player1.health--;
        bullets.remove(i);
        if (player1.health <= 0) {
          gameOver = true;
          winner = "Player 2 Wins!";
        }
      } else if (b.hits(player2)) {
        player2.health--;
        bullets.remove(i);
        if (player2.health <= 0) {
          gameOver = true;
          winner = "Player 1 Wins!";
        }
      } else if (b.isOffScreen()) {
        bullets.remove(i);
      }
    }

    drawHUD();
  }
}

void drawStartScreen() {
  fill(255);
  textSize(24);
  text("🚀 Tank Trouble Battle 🚀", width / 2, height / 2 - 60);
  text("Player 1: WASD + 1 to shoot", width / 2, height / 2 - 20);
  text("Player 2: Arrows + P to shoot", width / 2, height / 2 + 20);
  text("Press SPACE to start", width / 2, height / 2 + 80);
}

void drawEndScreen() {
  fill(255);
  textSize(32);
  text(winner, width / 2, height / 2);
  textSize(20);
  text("Press R to restart", width / 2, height / 2 + 50);
}

void drawHUD() {
  fill(255);
  textAlign(LEFT);
  text("Ammo: " + player1.ammo, 20, 20);
  text("HP: " + player1.health, 20, 50);

  textAlign(RIGHT);
  text("Ammo: " + player2.ammo, width - 20, 20);
  text("HP: " + player2.health, width - 20, 50);
}

void keyPressed() {
  if (!gameStarted && key == ' ') {
    gameStarted = true;
  } else if (gameOver && (key == 'r' || key == 'R')) {
    setup(); // restart the game
    gameStarted = true;
    gameOver = false;
    winner = "";
  }

  // Player 1 shoot
  if (key == '1' && player1.canShoot()) {
    bullets.add(player1.shoot());
  }

  // Player 2 shoot
  if ((key == 'p' || key == 'P') && player2.canShoot()) {
    bullets.add(player2.shoot());
  }
}
