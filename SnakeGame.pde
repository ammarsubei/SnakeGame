// The infamous snake game //<>//
// Base code from Daniel Shiffman
// Reference below:
//
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/AaGK-fj-BAM
//
// Snake game code
Snake player;
Button play;
Button exit;

int scl = 20;
boolean paused = false;
boolean doneWithMenu = false;
boolean isDead = false;

PVector food;

void setup() 
{
  size(800, 800);
  background(0);
  player = new Snake();
  frameRate(15);
  foodSpawn();

  // Initializing play button
  int playPosX = 350;
  int playPosY = 325;
  color c = color(255);
  color c2 = color(200);
  play = new Button(playPosX, playPosY, c, c2);
  
  // Initializing exit button
  int exitPosX = 350;
  int exitPosY = 400;
  exit = new Button(exitPosX, exitPosY, c, c2);
  
}


// Chooses a random spot to spawn new food
void foodSpawn() 
{
  int cols = width/scl;
  int rows = height/scl;

  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}


// Pauses the game from updating snake movement
void pauseMenu()
{
  // Keep displaying the snake and food
  fill(255, 0, 100);
  rect(food.x, food.y, scl, scl);
  player.show();

  // Transparent background
  fill(0, 60);
  rect(0, 0, width, height);

  // "Pause" message in the center
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("PAUSED", width/2, height/2);

  // Option for user to enter main menu
  textSize(30);
  textAlign(CENTER);
  text("Press 'SPACE' for main menu", width/2, 500);
}


// Checks for button presses in main menu
void checkButtonPress()
{
  if (mousePressed && (mouseButton == LEFT))
  {
    // Play button
    if (play.hover)
      doneWithMenu = true;
      
    // Exit button
    if (exit.hover)
      exit();
  }
}

void drawMainMenu()
{
  fill(100);
  rect(0, 0, width, height);

  play.update();
  exit.update();
  play.show();
  exit.show();
  
  fill(255);
  textSize(100);
  textAlign(CENTER, CENTER);
  text("SNAKE", width/2, 100);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("By Ammar Subei", width/2, 200);
  
  fill(0);
  textSize(30);
  textAlign(CENTER, CENTER);
  text("PLAY!", play.posX+(play.buttonWidth/2), play.posY+(play.buttonHeight/2));
  text("EXIT", exit.posX+(exit.buttonWidth/2), exit.posY+(exit.buttonHeight/2));
}

void playerDied()
{  
  fill(0);
  rect(0, 0, width, height);
  
  fill(255);
  textSize(30);
  textAlign(CENTER);
  text("You lost. Press SPACE to go to the main menu.", width/2, height/2);
}

void mousePressed() 
{
  // Deal with menu buttons
  if (!doneWithMenu)
    checkButtonPress();
  
  // Deal with in-game presses
  else
  {  
    if (mouseButton == LEFT)
      player.total += 2;
    else if (mouseButton == RIGHT)
    {
      println("Starting over");
      player.total = 0;
      player.tail.clear();
    }
  }
}

void draw() 
{
  // Main menu
  if (!doneWithMenu)
  {
    drawMainMenu();
    return;
  }
  
  if (isDead)
  {
    playerDied();
    return;
  }

  // Normal game play
  if (!paused)
  {
    background(60);

    if (player.eat(food))
      foodSpawn();

    fill(255, 0, 100);
    rect(food.x, food.y, scl, scl);

    isDead = player.death();
    player.update();    
    player.show();
  } 
  
  // Pause menu
  else
  {
    background(60);
    pauseMenu();
  }
}


void keyPressed() 
{
  // If the game is not paused or player is alive
  if (!paused && !isDead)
  {
    // Keep playing and read arrow keys
    
    if (keyCode == UP)
    {
      if (player.yspeed != 1)
        player.direction(0, -1);
    } else if (keyCode == DOWN)
    {
      if (player.yspeed != -1)
        player.direction(0, 1);
    } else if (keyCode == RIGHT) 
    {
      if (player.xspeed != -1)
        player.direction(1, 0);
    } else if (keyCode == LEFT) 
    {
      if (player.xspeed != 1)
        player.direction(-1, 0);
    }
  }
  else
  {
    // Otherwise press space to go back to main menu
    if (key == ' ')
    {
      player = new Snake();
      paused = false;
      doneWithMenu = false;
      isDead = false;
    }
  }
  
  // Allow user to pause after game starts
  if (doneWithMenu)
    if (key == ENTER || key == RETURN)
      paused = !paused;
}