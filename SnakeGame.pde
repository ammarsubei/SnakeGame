// The infamous snake game //<>//
// Base code from Daniel Shiffman
// Reference below:
//
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/AaGK-fj-BAM
//
// Snake game code

Snake s;
Button play;

int scl = 20;
boolean paused = false;
boolean doneWithMainMenu = false;

PVector food;

void setup() 
{
  size(800, 800);
  background(0);
  s = new Snake();
  frameRate(15);
  foodSpawn();

  // Initializing play button
  int playPosX = 340;
  int playPosY = 400;
  int playWidth = 100;
  int playHeight = 50;
  
  color c = color(255);
  color c2 = color(200);

  play = new Button(playPosX, playPosY, playWidth, playHeight, c, c2);
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
  s.show();

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
    {
      println("Pressed!");
      doneWithMainMenu = true;
    }
}

void drawMainMenu()
{
  fill(100);
  rect(0, 0, width, height);

  play.update();
  play.show();
  
  fill(0);
  textSize(32);
  text("PLAY!", 347, 436);
}

void mousePressed() 
{
  if (!doneWithMainMenu)
    checkMainMenu();

  else
  {  
    if (mouseButton == LEFT)
      s.total += 2;
    else if (mouseButton == RIGHT)
    {
      println("starting over");
      s.total = 0;
      s.tail.clear();
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

    if (s.eat(food))
      foodSpawn();

    fill(255, 0, 100);
    rect(food.x, food.y, scl, scl);

    s.death();
    s.update();    
    s.show();
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
      if (s.yspeed != 1)
        s.direction(0, -1);
    } else if (keyCode == DOWN)
    {
      if (s.yspeed != -1)
        s.direction(0, 1);
    } else if (keyCode == RIGHT) 
    {
      if (s.xspeed != -1)
        s.direction(1, 0);
    } else if (keyCode == LEFT) 
    {
      if (s.xspeed != 1)
        s.direction(-1, 0);
    }
  }
  if (key == ENTER || key == RETURN)
    paused = !paused;
}