
public class BoundingBox {
  
  private float x, y, w, h;
  
  public BoundingBox(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  public boolean intersects(BoundingBox b) {    
    return (x + w >= b.getX()) && (x <= b.getX() + b.getW()) && (y + h >= b.getY()) && (y <= b.getY() + b.getH());
  }
  
  public void setX(float x) {
    this.x = x;
  }
  
  public void setY(float y) {
    this.y = y;
  }
  
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public float getW() {
    return w;
  }
  
  public float getH() {
    return h;
  }
}
