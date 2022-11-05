public class Rectangle {
  
  public float x, y, w, h;
  
  public Rectangle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public Rectangle(float x, float y) {
    this.x = x * 32;
    this.y = y * 32;
    this.w = 32;
    this.h = 32;
  }
  
  public boolean overlaps(Rectangle r) {
    return x < r.x + r.w && x + w > r.x && y < r.y + r.h && y + h > r.y;
  }
  
  public void draw(boolean debugShape) {
    if(debugShape && !debug)
      return;
    rect(x, y, w, h);
  }
  
}

public class Line {
  
  public PVector p1;
  public PVector p2;
  
  public Line(float x1, float y1, float x2, float y2) {
    p1 = new PVector(x1, y1);
    p2 = new PVector(x2, y2);
  }
  
  public Line(PVector p1, PVector p2) {
    this.p1 = p1;
    this.p2 = p2;
  }
  
  public void draw(boolean debugShape) {
    if(debugShape && !debug)
      return;
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
}
