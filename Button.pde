// The infamous snake game
// Base code from Daniel Shiffman
// Reference below:
//
// http://codingtra.in
// http://patreon.com/codingtrain
// Code for: https://youtu.be/AaGK-fj-BAM
//
// Button class

class Button {
  int posX = 0;
  int posY = 0;
  int buttonWidth = 100;
  int buttonHeight = 50;

  color basecolor, highlightcolor;
  color currentcolor;

  boolean hover = false;

  Button(int ix, int iy, color icolor, color ihighlight)
  {
    posX = ix;
    posY = iy;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    println("Button initialized!");
  }

  boolean over(int x, int y, int w, int h) 
  {
    if (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h)
    {
      hover = true;
      return true;
    }
    else
    {
      hover = false;
      return false;
    }
  }

  void update() 
  {
    if (over(posX, posY, buttonWidth, buttonHeight))
      currentcolor = highlightcolor;
    else
      currentcolor = basecolor;
  }

  void show() 
  {
    //rectMode(CENTER);
    fill(currentcolor);
    rect(posX, posY, buttonWidth, buttonHeight);
  }
}