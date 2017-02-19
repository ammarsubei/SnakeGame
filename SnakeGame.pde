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
boolean doneWithMainMenu = false;

PVector food;

void setup() 
{
  size(800, 800);
  background(0);
  player = new Snake();
  frameRate(15);
  foodSpawn();

  // Initializing play button
  int playPosX = 340;
  int playPosY = 350;
  color c = color(255);
  color c2 = color(200);
  play = new Button(playPosX, playPosY, c, c2);
  
  // Initializing exit button
  int exitPosX = 340;
  int exitPosY = 420;
  exit = new Button(exitPosX, exitPosY, c, c2);
  
}

void foodSpawn() 
{
  int cols = width/scl;
  int rows = height/scl;

  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}

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
  text("PAUSED", 400, 400);
}


void checkMainMenu()
{
  if (mousePressed && (mouseButton == LEFT))
    if (play.hover)
      doneWithMainMenu = true;
      
    if (exit.hover)
      exit();
}

void drawMainMenu()
{
  fill(100);
  rect(0, 0, width, height);

  play.update();
  exit.update();
  play.show();
  exit.show();
  
  fill(0);
  textSize(32);
  textAlign(CENTER, CENTER);
  text("PLAY!", play.posX+(play.buttonWidth/2), play.posY+(play.buttonHeight/2));
  fill(0);
  textSize(32);
  text("EXIT", exit.posX+(exit.buttonWidth/2), exit.posY+(exit.buttonHeight/2));
}

void mousePressed() 
{
  if (!doneWithMainMenu)
    checkMainMenu();

  else
  {  
    if (mouseButton == LEFT)
      player.total += 2;
    else if (mouseButton == RIGHT)
    {
      println("starting over");
      player.total = 0;
      player.tail.clear();
    }
  }
}

void draw() 
{
  if (!doneWithMainMenu)
  {
    drawMainMenu();
    return;
  }

  if (!paused)
  {
    background(60);

    if (player.eat(food))
      foodSpawn();

    fill(255, 0, 100);
    rect(food.x, food.y, scl, scl);

    player.death();
    player.update();    
    player.show();
  } else
  {
    background(60);
    pauseMenu();
  }
}


void keyPressed() 
{
  if (!paused)
  {
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
  if (key == ENTER || key == RETURN)
    paused = !paused;
}