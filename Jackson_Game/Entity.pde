
public abstract class Entity {
  
  protected float x, y, w, h;
  protected color c;
  protected BoundingBox bounds;
  
  public Entity(float x, float y, float w, float h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    bounds = new BoundingBox(x, y, w, h);
  }
  
  public void update() {
    fill(c);
    rect(x, y, w, h);
    bounds.setX(x);
    bounds.setY(y);
  }
  
  public BoundingBox getBounds() {
    return bounds;
  }
}
