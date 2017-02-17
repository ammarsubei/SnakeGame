class Button {
  int posX = 0;
  int posY = 0;
  int buttonWidth = 0;
  int buttonHeight = 0;
  
  color basecolor, highlightcolor;
  color currentcolor;
  
  boolean hover = false;
  
  Button(int ix, int iy, int iwidth, int iheight, color icolor, color ihighlight)
  {
    posX = ix;
    posY = iy;
    buttonWidth = iwidth;
    buttonHeight = iheight;
    basecolor = icolor;
    highlightcolor = ihighlight;
    currentcolor = basecolor;
    println("Button initialized!");
  }

  boolean pressed() 
  {
    return hover;
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
    rectMode(CENTER);
    fill(currentcolor);
    rect(posX, posY, buttonWidth, buttonHeight);
  }
}