

public abstract class Entity {

  float x, y;
  int w, h;
  PVector velocity = new PVector();
  boolean hasGravity, onGround = false, active = true;
  BoundingBox bounds;

  public Entity(float x, float y, int w, int h, boolean hasGravity) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.hasGravity = hasGravity;
    
    bounds = new BoundingBox(0,0,w,h);
  }

  public void tick() {
    if(hasGravity) {
      velocity.add(new PVector(0,gravity));
    }
    
    for(Entity e: entities) {
      
    }
    
    x += velocity.x;
    y += velocity.y;
  }
  
  public void render() {
    fill(255,255,0);
    stroke(255,200,0);
    rect(x,y,bounds.getW(), bounds.getH());
  }
  
  public void addForce(PVector force) {
    velocity.add(force);
  }
  
  public BoundingBox getCollisionBounds(float xOffset, float yOffset) {
    return new BoundingBox((int)(x + bounds.x + xOffset), (int)(y + bounds.y + yOffset), bounds.w, bounds.h);
  }
  
  public boolean checkEntityCollisions(BoundingBox collisionBounds) {
    for(Entity e: entities) {
      if(e.getCollisionBounds(0f,0f).intersects(collisionBounds)) {
        return true;
      }
    }
    return false;
  }
  
  
  //Getters and Setters
  public float getX() {
    return x;
  }
  
  public float getY() {
    return y;
  }
  
  public boolean isActive() {
    return active;
  }
  
  public void setActive(boolean active) {
    this.active = active;
  }
  
  public boolean isHasGravity() {
    return hasGravity;
  }
  
  public void setHasGravity(boolean hasGravity) {
    this.hasGravity = hasGravity;
  }
}

public class StaticEntity extends Entity {
  public StaticEntity(float x, float y, int w, int h) {
    super(x, y, w, h, false);
  }
}

public class Creature extends Entity{
  
  public Creature(float x, float y, int w, int h) {
    super(x, y, w, h, true);
  }
}
