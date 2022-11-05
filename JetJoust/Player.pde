
public class Player {
  
  float x, y;
  int c;
  Line[] bounds;
  PVector velocity;
  PVector direction;
  
  public Player(float spawnX, float spawnY, int c) {
    x = spawnX;
    y = spawnY;
    this.c = c;
    
    velocity = new PVector(0,0);
    direction = new PVector(0,1);
  }
  
  public void update() {
    x += velocity.x;
    y += velocity.y;
    
    PVector perpendicular = new PVector(direction.y, direction.x);
    point(x, y);
    triangle(x + (0*direction.x + 10*perpendicular.x), y + (0*direction.y + 10*perpendicular.y), x + (-5*direction.x + -2*perpendicular.x), y + (-5*direction.y + -2*perpendicular.y),x + (5*direction.x + -2*perpendicular.x), y + (5*direction.y + 10*perpendicular.y));
  }
}
