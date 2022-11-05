
public abstract class Creature extends Entity{
  
  boolean hasGravity = true;
  PVector velocity = new PVector(0,0);
  
  public Creature(float x, float y, float w, float h, color c) {
    super(x, y, w, h, c);
  }
  
  protected void move() {
    
    boolean colliding = false;
    for(Entity e: entities) {
      if(!e.equals(this)) {
        if(bounds.intersects(e.getBounds())) {
          colliding = true;
        }
      }
    }
    if(!colliding) {
      x += velocity.x;
      y += velocity.y;
    }
  }
  
  public void addForce(float xMove, float yMove) {
    velocity.add(new PVector(xMove, yMove));
  }
  
  @Override
  public void update() {
    super.update();
    
    if(velocity.y < 8) {
      addForce(0, 1);
    }
    
    move();
  }
}
