class Button extends Widget
{   
  private float timeLastTurnedOn;
  private int resetDelay; //milliseconds
  private Boolean resetEnable; //bounces button back to normal after resetDelay
  
  public Button()
  {
     super(); 
     this.resetDelay = 0;
     this.resetEnable = true;
  }
  
  public Button enableReset(Boolean tog)
  {
    this.resetEnable = tog; 
    return this;
  }
  
  public Button setResetDelay(int d)
  {
    this.resetEnable = true;
    this.resetDelay = d;
    return this;
  }  
  
  @Override
  public void toggle(Boolean toggle)
  {
    super.status = toggle;
    if(super.status)
      this.timeLastTurnedOn = millis();
  }
  
  @Override
  public void toggle()
  {
    super.status = !super.status;
    if(super.status)
      this.timeLastTurnedOn = millis();
  }
  
  public Boolean isPressed(float x, float y)
  {
    if((super.height + super.upperBound >= y) && (super.upperBound <= y) && (super.leftBound + super.width >= x) &&  (super.leftBound <=x)){
      if(!this.resetEnable) //if automatic reset is not enabled
        this.toggle();
      else
        this.toggle(true);
      return true;
    }
    return false;
  }
  
  @Override
  public void draw()
  {
    tint(super.opacityColor, super.opacity);
    if(super.status) // status == ON
    {
      image(super.imgON, super.leftBound, super.upperBound, super.width, super.height);
      if(resetEnable && (millis() - resetDelay > timeLastTurnedOn)) //keep it on briefly for half a second
        super.status = false;        
    }
    else
    {
      image(super.imgOFF, super.leftBound, super.upperBound, super.width, super.height);
    }
    if(super.text != null)
    {
      textFont(super.textFont);
      fill(super.textFill);
      rectMode(RADIUS);
      textAlign(CENTER, CENTER);
      text(super.text, super.leftBound +  super.width/2, super.upperBound + super.height/2); 
    }    
    noTint();
  }
}
