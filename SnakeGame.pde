// The infamous snake game //<>//
//
// Base code from Daniel Shiffman
// Reference below:
//
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/AaGK-fj-BAM

Snake s;
Button play;

int scl = 20;
boolean paused = false;

PVector food;

void setup() 
{
  size(800, 800);
  background(0);
  s = new Snake();
  frameRate(15);
  foodSpawn();
  
  // Declaring button positions
  int playPosX = width/2;
  int playPosY = height/2;
  int playWidth = 70;
  int playHeight = 30;

  color c = color(255, 0, 0);
  color c2 = color(0, 0, 255);

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

int mainMenu()
{
  fill(255, 0, 0);
  rect(0, 0, width, height);
  
  while (true)
  {
    play.update();
    play.show();

    if (mousePressed && (mouseButton == LEFT))
    {
      if (play.hover)
      {
        println("Pressed!");
        return 1;
      }
    }
  }
}

void mousePressed() 
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

void draw() 
{
  int something = mainMenu();

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
  } 
  else
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