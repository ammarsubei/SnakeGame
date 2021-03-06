// The infamous snake game
// Base code from Daniel Shiffman
// Reference below:
//
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/AaGK-fj-BAM
//
// Snake class

class Snake {
  float x = 0;
  float y = 0;
  float xspeed = 1;
  float yspeed = 0;

  int total = 0;

  ArrayList<PVector> tail = new ArrayList<PVector>();

  Snake() {}

  boolean eat(PVector food) 
  {
    float d = dist(x, y, food.x, food.y);

    if (d < 1) 
    {
      total++;
      return true;
    } 
    else 
      return false;
  }

  void direction(float x, float y) 
  {
    xspeed = x;
    yspeed = y;
  }

  boolean death() 
  {
    for (int i = 0; i < tail.size(); i++) 
    {
      PVector pos = tail.get(i);
      float d = dist(x, y, pos.x, pos.y);

      if (d < 1) 
      {
        total = 0;
        tail.clear();
        return true;
      }
    }
    return false;
  }

  void wrap()
  {
    if (x > width-scl)
      x = 0;
    if (y > height-scl)
      y = 0;
    if (x < 0)
      x = width-scl;
    if (y < 0)
      y = height-scl;
  }

  void update() 
  {
    if (total > 0) 
    {
      if (total == tail.size() && !tail.isEmpty())
        tail.remove(0);

      tail.add(new PVector(x, y));
    }

    x = x + xspeed*scl;
    y = y + yspeed*scl;

    // Need to wrap around to other side 
    wrap();
  }

  void show() 
  {
    fill(255);
    for (PVector v : tail)
      rect(v.x, v.y, scl, scl);

    rect(x, y, scl, scl);
  }
}