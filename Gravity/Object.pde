
public class Object {
  
  private float x, y, mass, size;
  private PVector velocity;
  
  
  public Object(float x, float y, float mass, float size) {
    this.x = x;
    this.y = y;
    this.mass = mass;
    this.size = size;
    velocity = new PVector(0,0);
  }
  
  public Object(float x, float y, float mass, float size, float initVelX, float initVelY) {
    this.x = x;
    this.y = y;
    this.mass = mass;
    this.size = size;
    velocity = new PVector(initVelX, initVelY);
  }
  
  public void update() {
  
  }
  
  private void move() {
  
  }
}
