
public class Missile {
  
  protected float x, y, startX, startY, speed;
  protected PVector direction;
  public boolean active = true;
  public Missile(int startX, int startY, int speed, PVector target) {
    this.x = startX;
    this.y = startY;
    this.startX = startX;
    this.startY = startY;
    this.speed = speed;
    
    target.x -= x;
    target.y -= y;
    this.direction = target.normalize();
  }
  
  public void update() {
    strokeWeight(5);
    stroke(0);
    line(x, y, startX - (startX - x)/2, startY - (startY - y)/2);
    x += direction.x * speed;
    y += direction.y * speed;
    
    for(DamageCloud c: damageClouds) {
      if(c.pointIntersects((int)x, (int)y)) {
        active = false;
      }
    }
  }
}

public class PlayerMissile extends Missile {
  
  
  PVector targetPosition;
  
  public PlayerMissile(int targetX, int targetY) {
    super(400, 650, 3, new PVector(targetX, targetY));
    
    targetPosition = new PVector(targetX, targetY);
  }
  
  @Override
  public void update() {
    super.update();
    
    stroke(0);
    fill(255,0,0);
    //circle(targetPosition.x, targetPosition.y, 5);
    
    if((targetPosition.x < x + 2 && targetPosition.x > x - 2) && (targetPosition.y < y + 2 && targetPosition.y > y - 2)) {
      active = false;
      damageClouds.add(new DamageCloud((int)x, (int)y, 100));
    }
  }
}

public class EnemyMissile extends Missile {
  public EnemyMissile(int speed) {
    super(round(random(0, width)), 0, speed, floor(random(0,2)) == 0? new PVector(150, 700): new PVector(650,700));
  }
  
  @Override
  public void update() {
    super.update();
    if(y > 650) {
      
      gameOver = true;
      active = false;
    }
  }
}

public class DamageCloud {
  
  private int x, y, r, maxR;
  
  public DamageCloud(int x, int y, int maxR) {
    this.x = x;
    this.y = y;
    this.maxR = maxR;
  }
  
  public void update() {
    strokeWeight(10 * ((float)r/ (float)maxR));
    stroke(50,50,100);
    fill(100,100,200);
    circle(x, y, r);
    r ++;
  }
  
  public boolean pointIntersects(int px, int py) {
    return(dist(x, y, px, py) + 3 < r);
  }
  
  public boolean isMaxRaduisReached() {
    missileReady = r >= maxR;
    return r >= maxR;
  }
}
