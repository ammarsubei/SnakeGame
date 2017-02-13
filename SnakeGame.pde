// The infamous snake game
// Base code from Daniel Shiffman
// Reference below:
//
// Daniel Shiffman
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/AaGK-fj-BAM

Snake s;
int scl = 20;

PVector food;

void setup() 
{
  size(800, 800);
  s = new Snake();
  frameRate(5);
  pickLocation();
}

void pickLocation() 
{
  int cols = width/scl;
  int rows = height/scl;
  
  food = new PVector(floor(random(cols)), floor(random(rows)));
  food.mult(scl);
}

void mousePressed() 
{
  if (mouseButton == LEFT)
    s.total++;
  else if (mouseButton == RIGHT)
    {
      println("starting over");
      s.total = 0;
      s.tail.clear();
    }
}

void draw() 
{
  background(51);

  if (s.eat(food))
    pickLocation();
    
  fill(255, 0, 100);
  rect(food.x, food.y, scl, scl);
  
  s.death();
  s.update();    
  s.show();
}


void keyPressed() 
{
  if (keyCode == UP)
  {
    if (s.yspeed != 1)
      s.direction(0, -1);
  }
  else if (keyCode == DOWN)
  {
    if (s.yspeed != -1)
      s.direction(0, 1);
  }
  else if (keyCode == RIGHT) 
  {
    if (s.xspeed != -1)
      s.direction(1, 0);
  }
  else if (keyCode == LEFT) 
  {
    if (s.xspeed != 1)
      s.direction(-1, 0);
  }
}