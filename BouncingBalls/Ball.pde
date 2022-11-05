
public class Ball {
  float x, y;
  int r, c, id;
  PVector v;
  boolean dragging = false;
  
  public Ball(int id, float x, float y, float vx, float vy, int r, int c) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.v = new PVector(vx, vy);
    this.r = r;
    this.c = c;
  }
  
  public void tick() {
    if(mousePressed && mouseButton == LEFT && dist(x, y, pmouseX, pmouseY) < r) {
      dragging = true;
      x = mouseX;
      y = mouseY;
      v.x = mouseX - pmouseX;
      v.y = mouseY - pmouseY;
    }else {
      dragging = false;
      x += v.x;
      y += v.y;
    }
    
    
    
    if(x < r) {
      x = r;
      v.x *= -1;
    }else if(x > width-r) {
      x = width-r;
      v.x *= -1;
    }
    
    if(y < r) {
      y = r;
      v.y *= -1;
    }else if(y > height-r) {
      y = height-r;
      v.y *= -1;
    }
    v.y += 1;
    
    
    
    
    noStroke();
    fill(c);
    circle(x, y, r*2);
    textAlign(CENTER);
    fill(255);
    text(id, x, y+5);
    
    checkCollision();
  }
  
  public void checkCollision() {
    for(int i = 0; i < balls.size(); i++) {
      Ball b2 = balls.get(i);
      if(b2 == this) continue;
      if(dist(x, y, b2.x, b2.y) >= r + b2.r) continue;
      
      PVector direction = new PVector(b2.x - x, b2.y - y).normalize();
      float angle1 = PVector.angleBetween(direction, v);
      float angle2 = PVector.angleBetween(PVector.mult(direction, -1), b2.v);
      
      angle1 = min((PI/2f), max(angle1, (PI/-2f)));
      angle2 = min((PI/2f), max(angle2, (PI/-2f)));
      
      PVector force1 = PVector.mult(direction, v.mag() * cos(angle1) * (r * r * PI));
      PVector force2 = PVector.mult(PVector.mult(direction, -1), b2.v.mag() * cos(angle2) * (b2.r * b2.r * PI));
      
      //println("Angle between d and v: " + angle1);
      //println("Angle between d and v2: " + angle2);
      
      //stroke(0,255,0);
      //strokeWeight(5);
      //line(x, y, force1.x/100 + x, force1.y/100 + y);
      
      //stroke(255,0,255);
      //strokeWeight(2);
      //line(b2.x, b2.y, force2.x/100 + b2.x, force2.y/100 + b2.y);
      
      //stroke(255,0,0);
      //fill(255);
      //circle(x, y, 2);
      //line(x, y, direction.x*10 + x, direction.y*10 + y);
      
      //noLoop();
      
      b2.v.add(PVector.div(force1, b2.r * b2.r * PI).mult(0.9));
      v.sub(PVector.div(force1, r * r * PI).mult(0.9));
      
      v.add(PVector.div(force2, r * r * PI).mult(0.9));
      b2.v.sub(PVector.div(force2, b2.r * b2.r * PI).mult(0.9));
      
      if(dragging) {
        b2.x = x + direction.x * (r + b2.r);
        b2.y = y + direction.y * (r + b2.r);
        continue;
      }
      x = b2.x - direction.x * (r + b2.r);
      y = b2.y - direction.y * (r + b2.r);
      
    }
  }
  
}
