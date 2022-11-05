
class LaserBeam{
  
  PVector start;
  PVector end = new PVector();
  PVector direction;
  LaserBeam(PVector direction, PVector origin) {
    start = origin;
    this.direction = direction;
    this.direction.normalize();
    this.direction.mult(100);
    PVector.add(origin ,this.direction, end);
  }
  
  void update() {
    noStroke();
    fill(255, 0, 0);
    
    for(int i = 0; i < 10; i ++) {
      rect(start.x - ((start.x - end.x)/10) * i, start.y - ((start.y - end.y)/10) * i, 10, 10);
    }
    
    rect(start.x, start.y, 10, 10);
    rect(end.x, end.y, 10, 10);
    start = end.copy();
    
    PVector.add(start ,direction, end);
  }
}

class LaserManager {
  ArrayList<LaserBeam> lasers = new ArrayList<LaserBeam>();
  
  LaserManager() {
  
  }
  
  void update() {
    for(LaserBeam l:lasers) {
      l.update();
    }
  }
  
  void add(LaserBeam laser) {
    lasers.add(laser);
  }
}
