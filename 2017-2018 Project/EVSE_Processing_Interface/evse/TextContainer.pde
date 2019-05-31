class TextContainer extends Widget //read only 
{
  @Override
  public void draw()
  {
    tint(#FF2A00  , super.opacity);
    rectMode(CORNER);
    if(super.imgON != null)
      image(super.imgON, super.leftBound, super.upperBound, super.width, super.height);
    else
    { 
      fill(super.rectFillOff, (float) super.opacity);
      noStroke();
      rect(super.leftBound, super.upperBound, super.width, super.height);
    }
    if(super.text != null)
    {
      textFont(super.textFont);
      fill(super.textFill);
      rectMode(CORNER);
      textAlign(LEFT, CENTER);
      text(super.text, super.leftBound +  10, super.upperBound + super.height/2); 
    }
    noTint();
  }
}
