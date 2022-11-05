


public class Particle {
  
  float x, y, m;
  PVector velocity = new PVector(0,0);
  
  public Particle(float x, float y, float m, PVector initVel) {
    this.x = x;
    this.y = y;
    this.m = m;
    this.velocity = initVel;
  }
  
  public void update() {
    fill(255,0,0);
    circle(x, y, 10);
    
    addForce(new PVector(0,1), gravityForce);
    
    x += velocity.x;
    y += velocity.y;
  }
  
  public void addForce(PVector direction, float f){
    velocity.add(direction.setMag(f/m));
  }
}
