//import processing.sound.*;

GameMap map;
Tank player1, player2;
ArrayList<Bullet> bullets;

String state = "START";
PFont font;

// Sound effects
//SoundFile shootSound;
//SoundFile hitSound;
//SoundFile gameOverSound;

boolean wPressed, aPressed, sPressed, dPressed;
boolean upPressed, downPressed, leftPressed, rightPressed;

void setup() {
  size(1000, 700);
  map = new GameMap();
  bullets = new ArrayList<Bullet>();
  font = createFont("Arial", 16);
  textFont(font);

  //shootSound = new SoundFile(this, "shoot.wav");
 //hitSound = new SoundFile(this, "hit.wav");
  //gameOverSound = new SoundFile(this, "gameover.wav");

  setupPlayers();
}

void draw() {
  background(0);  // Black background

  if (state.equals("START")) {
    drawStartScreen();
  } else if (state.equals("PLAYING")) {
    map.draw();
    updateGame();
    drawHUD();
  } else if (state.equals("GAMEOVER")) {
    drawEndScreen();
  }
}

void drawStartScreen() {
  fill(255);  // White text
  textAlign(CENTER, CENTER);
  textSize(36);
  text("Terry's Tank Battle", width / 2, height / 2 - 60);
  textSize(20);
  text("P1: WASD + 1 to shoot", width / 2, height / 2 - 10);
  text("P2: Arrows + P to shoot", width / 2, height / 2 + 20);
  text("Press SPACE to Start", width / 2, height / 2 + 60);
}

void drawEndScreen() {
  fill(255);  // White text
  textAlign(CENTER, CENTER);
  textSize(36);
  String winner = player1.isDead() ? "Player 2 Wins!" : "Player 1 Wins!";
  text(winner, width / 2, height / 2);
  textSize(20);
  text("Press SPACE to Restart", width / 2, height / 2 + 40);
}

void keyPressed() {
  if (key == 'w') wPressed = true;
  if (key == 'a') aPressed = true;
  if (key == 's') sPressed = true;
  if (key == 'd') dPressed = true;

  if (keyCode == UP) upPressed = true;
  if (keyCode == DOWN) downPressed = true;
  if (keyCode == LEFT) leftPressed = true;
  if (keyCode == RIGHT) rightPressed = true;

  if (key == '1' && state.equals("PLAYING") && player1.canShoot()) {
    Bullet b = player1.shoot();
    if (b != null) {
      bullets.add(b);
//shootSound.play();
    }
  }

  if (key == 'p' && state.equals("PLAYING") && player2.canShoot()) {
    Bullet b = player2.shoot();
    if (b != null) {
      bullets.add(b);
      //shootSound.play();
    }
  }

  if (key == ' ') {
    if (state.equals("START")) state = "PLAYING";
    else if (state.equals("GAMEOVER")) restartGame();
  }
}

void keyReleased() {
  if (key == 'w') wPressed = false;
  if (key == 'a') aPressed = false;
  if (key == 's') sPressed = false;
  if (key == 'd') dPressed = false;

  if (keyCode == UP) upPressed = false;
  if (keyCode == DOWN) downPressed = false;
  if (keyCode == LEFT) leftPressed = false;
  if (keyCode == RIGHT) rightPressed = false;
}

void updateGame() {
  player1.handleMovement();
  player2.handleMovement();
  player1.update();
  player2.update();

  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();

    if (b.checkCollision(player1) && !player1.isDead() && b.shooter != player1) {
      player1.takeDamage();
      bullets.remove(i);
      //hitSound.play();
    } else if (b.checkCollision(player2) && !player2.isDead() && b.shooter != player2) {
      player2.takeDamage();
      bullets.remove(i);
      //hitSound.play();
    } else if (b.isOutOfBounds()) {
      bullets.remove(i);
    }
  }

  if (player1.isDead() || player2.isDead()) {
    state = "GAMEOVER";
    //gameOverSound.play();
  }
}

void drawHUD() {
  fill(255);
  textAlign(LEFT, TOP);
  text("Ammo: " + player1.ammo, 10, 10);
  drawHealthBar(player1, 10, 30);

  textAlign(RIGHT, TOP);
  text("Ammo: " + player2.ammo, width - 10, 10);
  drawHealthBar(player2, width - 110, 30);
}

void drawHealthBar(Tank t, float x, float y) {
  float barWidth = 100;
  float barHeight = 15;
  float healthRatio = t.health / 3.0;

  noStroke();
  fill(255, 0, 0); // background red
  rect(x, y, barWidth, barHeight);
  fill(0, 255, 0); // green for remaining
  rect(x, y, barWidth * healthRatio, barHeight);
}

void setupPlayers() {
  float offset = 50;
  player1 = new Tank(offset + 100, height / 2, color(0, 100, 255), map);
  player2 = new Tank(width - offset - 100, height / 2, color(255, 100, 0), map);
}

void restartGame() {
  setupPlayers();
  bullets.clear();
  state = "PLAYING";
}
