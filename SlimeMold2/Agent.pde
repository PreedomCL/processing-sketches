
public class Agent {
  
  float x, y;
  PVector direction;
  float independance = 0.001f;
  float exploration  = 0.01f;
  float turnAccuracy = 1f;
  public Agent(int x, int y, PVector initDirection) {
    this.x = x;
    this.y = y;
    direction = initDirection;
    direction.normalize();
  }
  
  public void update() {
    
    /*
       o
      o o
       X
    */
    //float top = red(pixels[(width * min(max(round(y + direction.y * 2), 0), height-1)) + min(max(round(x + direction.x * 2), 0), width-1)]);
    //float left = red(pixels[(width * min(max(round(y + direction.y + direction.x * 2), 0), height-1)) + min(max(round(x + direction.y * -1), 0), width-1)]);
    //float right = red(pixels[(width * min(max(round(y + direction.y + direction.x * -2), 0), height-1)) + min(max(round(x + direction.y * 1), 0), width-1)]);
    
    /*
     o
    oXo
    */    
    float top = red(pixels[(width * min(max(round(y + direction.y), 0), height-1)) + min(max(round(x + direction.x), 0), width-1)]);
    float left = red(pixels[(width * min(max(round(y + direction.x * 1), 0), height-1)) + min(max(round(x + direction.y * -1), 0), width-1)]);
    float right = red(pixels[(width * min(max(round(y + direction.x * -1), 0), height-1)) + min(max(round(x + direction.y * 1), 0), width-1)]);
    
    PVector targetDirection;
    if(top < 1 && left < 1 && right < 1) {
      direction.add(new PVector((random(2)-1) * exploration, (random(2)-1) * exploration));
    }else if(top >= left && top >= right) {
      targetDirection = new PVector(min(max(round(x + direction.x * 2), 0), width-1) - x,min(max(round(y + direction.y * 2), 0), height-1) - y).normalize();
      direction.add(targetDirection.sub(direction).mult(turnAccuracy));
    }else if(left > top && left > right) {
      targetDirection = new PVector(min(max(round(x + direction.y * -2), 0), width-1) - x,min(max(round(y + direction.y + direction.x * 2), 0), height-1) - y).normalize();
      direction.add(targetDirection.sub(direction).mult(turnAccuracy));
    }else if(right > top && right > left) {
      targetDirection = new PVector(min(max(round(x + direction.y * 2), 0), width-1) - x,min(max(round(y + direction.y + direction.x * -2), 0), height-1) - y).normalize();
      direction.add(targetDirection.sub(direction).mult(turnAccuracy));
    }
    
    
    
    //direction.add(new PVector((random(2)-1) * independance, (random(2)-1) * independance));
    direction.normalize();
    
    y += direction.y;
    x += direction.x;
    
    if(y < 0 || y > height) {
      direction.y *= -1;
      y = y < 0? 0 : height;
    }
    if(x < 0 || x > width) {
      direction.x *= -1;
      x = x < 0? 0 : width;
    }
    
    pixels[(width * min(round(y), height-1)) + min(round(x), width-1)] = color(255 - decay * 5);
    //pixels[(width * min(round(y), height-1)) + min(round(x + 1), width-1)] = color(255 - decay * 5);
    //pixels[(width * min(round(y), height-1)) + min(max(round(x - 1), 0), width-1)] = color(255 - decay * 5);
    //pixels[(width * min(round(y + 1), height-1)) + min(round(x), width-1)] = color(255 - decay * 5);
    //pixels[(width * min(max(round(y - 1), 0), height-1)) + min(round(x), width-1)] = color(255 - decay * 5);
  }
  
  
}
