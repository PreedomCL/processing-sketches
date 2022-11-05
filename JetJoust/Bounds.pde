
public abstract class BoundsComponent {
  
}

public class Line extends BoundsComponent{
  
  float x1, x2, y1, y2;
  
  public Line(float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.x2 = x2;
    this.y1 = y1;
    this.y2 = y2;
  } 
}

public class Rect extends BoundsComponent {
  
  float x, y, w, h;
  
  public Rect(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
}
