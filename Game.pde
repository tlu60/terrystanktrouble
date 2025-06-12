GameMap map;
Tank player1, player2;
ArrayList<Bullet> bullets;
PowerUp currentPowerUp;
int powerUpTimer = 0;
int powerUpCooldown = 600;

String state = "START";
PFont font;

boolean wPressed, aPressed, sPressed, dPressed;
boolean upPressed, downPressed, leftPressed, rightPressed;

void setup() {
  size(1000, 700);
  map = new GameMap();
  bullets = new ArrayList<Bullet>();
  font = createFont("Arial", 16);
  textFont(font);
  setupPlayers();
}

void draw() {
  background(0);
  if (state.equals("START")) {
    drawStartScreen();
  } else if (state.equals("PLAYING")) {
    map.draw();

    if (currentPowerUp == null && powerUpTimer <= 0) {
      currentPowerUp = new PowerUp(map);
    } else if (currentPowerUp == null && powerUpTimer > 0) {
      powerUpTimer--;
    }
    
    if (currentPowerUp != null) {
      currentPowerUp.draw();
      if (currentPowerUp.checkCollision(player1)) {
        player1.setPowerUp(currentPowerUp.type);
        currentPowerUp = null;
        powerUpTimer = powerUpCooldown;
      } else if (currentPowerUp.checkCollision(player2)) {
        player2.setPowerUp(currentPowerUp.type);
        currentPowerUp = null;
        powerUpTimer = powerUpCooldown;
      }
    }

    updateGame();
    
    // Draw tanks after updating
    player1.draw();
    player2.draw();
    
    for (Bullet b : bullets) {
      b.draw();
    }

    drawHUD();
  } else if (state.equals("GAMEOVER")) {
    drawEndScreen();
  }
}

void drawStartScreen() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(36);
  text("Terry's Tank Battle", width/2, height/2 - 60);
  textSize(20);
  text("P1: WASD + 1 to shoot", width/2, height/2 - 10);
  text("P2: Arrows + P to shoot", width/2, height/2 + 20);
  text("Press SPACE to Start", width/2, height/2 + 60);
}

void drawEndScreen() {
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(36);
  String winner = player1.isDead() ? "Player 2 Wins!" : "Player 1 Wins!";
  text(winner, width/2, height/2);
  textSize(20);
  text("Press SPACE to Restart", width/2, height/2 + 40);
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

  if (key == '1' && state.equals("PLAYING") && player1.canShoot()) bullets.add(player1.shoot());
  if (key == 'p' && state.equals("PLAYING") && player2.canShoot()) bullets.add(player2.shoot());

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

  for (int i = bullets.size()-1; i >= 0; i--) {
    Bullet b = bullets.get(i);
    b.update();
    if (b.checkCollision(player1) && !player1.isDead() && b.shooter != player1) {
      player1.takeDamage();
      bullets.remove(i);
    } else if (b.checkCollision(player2) && !player2.isDead() && b.shooter != player2) {
      player2.takeDamage();
      bullets.remove(i);
    } else if (b.isOutOfBounds()) {
      bullets.remove(i);
    }
  }

  if (player1.isDead() || player2.isDead()) state = "GAMEOVER";
}
void drawHUD() {
  textSize(18);
  noStroke();

  // Player 1 HUD (Left)
  fill(player1.tankColor);
  textAlign(LEFT, TOP);
  text("Ammo: " + player1.ammo, 20, 10);
  drawHealthBar(player1, 70, 40, 110, 20);
  text("Boost: " + (player1.activePowerUp != null ? player1.activePowerUp : "No Boost"), 20, 70);

  // Player 2 HUD (Right)
  fill(player2.tankColor);
  textAlign(RIGHT, TOP);
  text("Ammo: " + player2.ammo, width - 20, 10);
  drawHealthBar(player2, width - 80, 40, 110, 20);
  text("Boost: " + (player2.activePowerUp != null ? player2.activePowerUp : "No Boost"), width - 20, 70);
}

void drawHealthBar(Tank t, float x, float y, float barWidth, float barHeight) {
  float healthRatio = constrain(t.health / 3.0, 0, 1);
  noStroke();
  fill(255, 0, 0); // Red background
  rect(x, y, barWidth, barHeight);
  fill(0, 255, 0);   // Green foreground (current health)
  rect(x, y, barWidth * healthRatio, barHeight);
  stroke(255);
  noFill();
  rect(x, y, barWidth, barHeight); // Border
}

void setupPlayers() {
  float offset = 50;
  player1 = new Tank(offset, height/2, color(0, 100, 255), map);
  player2 = new Tank(width - offset, height/2, color(255, 100, 0), map);
}

void restartGame() {
  setupPlayers();
  bullets.clear();
  currentPowerUp = null;
  powerUpTimer = 0;
  state = "PLAYING";
}
