
public class UIManager {
  
  
  
  public UIManager() {
    
  }
  
  public void update() {
  
  }
}

public abstract class UIElement {
  
  public boolean active = false, visible = false;
  public int layer;
  public int x, y, w, h;
  
  public UIElement(int x, int y, int w, int h, int layer) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.layer = layer;
  }
  
  public abstract void update();
}

public class TextFeild extends UIElement{
  
  private String inputText, directions;
  
  public TextFeild(int x, int y, int w, int h, int layer, String directions) {
    super(x, y, w, h, layer);
    
    this.directions = directions;
  }
  
  public void update() {
    pushStyle();
      
      noStroke();
      fill(0,200);
      rect(x, y, w, h);
      
      textAlign(CENTER, CENTER);
      fill(255);
      text(directions, x + w/2, y); 
    
    popStyle();
  }
  
  public String getInputText() {
    return inputText;
  }
}
