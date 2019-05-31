class Widget
{  
  private PImage imgON;
  private PImage imgOFF;
  private Boolean status;
  private float leftBound;
  private float width;
  private float upperBound;
  private float height;
  private String text;
  private int textLength;
  private PFont textFont;
  private int textFill;
  private int opacity;
  private color opacityColor;
  private Boolean DEBUG;
  private int rectFillOff;
  private int rectFillOn;
  
  public Widget()
  {
    status = false;    
    text = "";
    textLength = 0;
    opacity = 255;
    opacityColor = 255;
    rectFillOff = 127;
    rectFillOn = 255;
    DEBUG = false;
  }
  
  public Widget setOpacity(color b, int i)
  {
    opacity = i;
    opacityColor = b;
    return this;
  }
  
  public Widget setRectFill(int on, int off)
  {
    rectFillOff = off;
    rectFillOn = on;
    return this;
  }
  
  public Widget setText(String s)
  {
    textLength = s.length();
    text = s;
    return this;
  }
  
  public Widget setTextFont(PFont f)
  {
    textFont = f;
    return this;
  }
  
  public Widget setTextFont(PFont f, int fill)
  {
    textFill = fill;
    textFont = f;
    return this;
  }
  
  public Widget setDebug(Boolean toggle)
  {
    DEBUG = toggle;
    return this;
  }
  
  public Widget setImage(String imgPathOFF)
  {
    imgOFF = loadImage(imgPathOFF);
    return this;
  }
  
  public Widget setImage(String imgPathON, String imgPathOFF)
  {
    imgON = loadImage(imgPathON);
    imgOFF = loadImage(imgPathOFF);
    return this;
  }
  
  public Widget setBounds(float left, float top, float w, float h) //upperbound is less than lowerbound
  {
    leftBound = left;
    upperBound = top;
    height = h;
    width = w;
    return this;
  }
  
  public Boolean isOn()
  {
    return status;
  }
  
  public void toggle(Boolean toggle)
  {
    status = toggle;
  }
  
  public void toggle()
  {
    status = !status;
  }
  
  public void draw()
  {
    rectMode(CORNER);
    tint(opacityColor, opacity);
    if(status) // status == ON
    {
      if(imgON != null)
        image(imgON, leftBound, upperBound, width, height);
      else
      {
        fill(rectFillOn);
        rect(leftBound, upperBound, width, height);
      }
    }
    else
    {
      if(imgOFF != null)
        image(imgOFF, leftBound, upperBound, width, height);
      else
      {
        fill(rectFillOff);
        rect(leftBound, upperBound, width, height);
      }
    }
    if(text != null)
    {
      textFont(textFont);
      fill(textFill);
      rectMode(RADIUS);
      textAlign(CENTER, CENTER);
      text(text, leftBound +  width/2, upperBound + height/2); 
    }
    noTint();
  }
}
