

public abstract class UIElement {
  
  public int x, y, w, h;
  
  protected boolean active = false, visible = false;
  
  public UIElement(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public abstract void update();
  
  public void setActive(boolean active) {
    this.active = active;
  }
  
  public void setVisible(boolean visible) {
    this.visible = visible;
  }
}

public abstract class ClickableUIElement extends UIElement {
  
  public ClickableUIElement(int x, int y, int w, int h) {
    super(x, y, w, h);
  }
  
  public abstract void onClick();
}

public class TextFeild extends UIElement{
  
  private String inputText = "", directions;
  public boolean textSubmitted = false;
  
  public TextFeild(int x, int y, int w, int h, String directions) {
    super(x, y, w, h);
    
    this.directions = directions;
  }
  
  public void update() {
    
    if(visible) {
      pushStyle();
        
        noStroke();
        fill(0,200);
        rect(x, y, w, h);
        
        textAlign(CENTER, TOP);
        textSize(20);
        fill(255);
        text(directions, x + w/2, y + 5);
        text(inputText, x + w/2, y + 22);
      
      popStyle();
    }
    
    if(active) {
      
      if(keyJustPressed) {
        if(key == ENTER) {
          active = false;
          visible = false;
          textSubmitted = true;
        }else if(key == BACKSPACE) {
          inputText = "";
        }else {
          inputText += key;
        }
      }
    }
  }
  
  public String getInputText() {
    return inputText;
  }
}
