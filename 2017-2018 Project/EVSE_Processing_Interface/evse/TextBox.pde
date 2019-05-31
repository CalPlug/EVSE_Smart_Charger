class TextBox extends Widget
{
  private Boolean numbersEnable = true;
  private Boolean lettersEnable = true;
  private Boolean decimalEnable = true;
  private Boolean colonEnable = true;
  
  public TextBox enableNumbers(Boolean e)
  {
    numbersEnable = e;
    return this;
  }
  
  public TextBox enableLetters(Boolean e)
  {
    lettersEnable = e;
    return this;
  }
  
  public TextBox enableDecimal(Boolean e)
  {
    decimalEnable = e;
    return this;
  }
  
  public Boolean isPressed(float x, float y)
  {
    if((super.height + super.upperBound >= y) && (super.upperBound <= y) && (super.leftBound + super.width >= x) &&  (super.leftBound <=x)){
      super.status = true;
    }else{
      super.status = false;
    }
    return super.status;
  }
  
  public Boolean keyPressed(char k, int keycode)
  {
    if(super.status)
    {
      if(keycode == (int) BACKSPACE){
        backspace();
      }else if(keycode == 32){
        addChar(' ');
      }else if(keycode == (int) ENTER){
        return true;
      }else{
        if((k >= 'A' && k <= 'Z' && lettersEnable) ||
           (k >= 'a' && k <= 'z' && lettersEnable) ||
           (k >= '0' && k <= '9' && numbersEnable) ||
           (k == '.' && decimalEnable) ||
           (k == ':' && colonEnable)
           ){
             addChar(k);
           }
      }
    }
    return false;
  }
  
  private void addChar(char ch)
  {
    if(textWidth(super.text + ch) < super.width)
    {
      super.text += ch;
      super.textLength++;
    }
  }
  
  private void backspace()
  {
    if(super.textLength - 1 >= 0)
    {
      super.text = super.text.substring(0, super.textLength -1);
      super.textLength--;
    }
  }
  
  public String getText()
  {
    return super.text;
  }
  
  public void clear()
  {
    super.text = "";
  }
}
