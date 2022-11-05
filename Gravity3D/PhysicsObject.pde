

class PhysicsObject {
  
  boolean staticPos = false;
  boolean active = true;
  float mass;
  float density;
  float radius;
  PVector position;
  PVector velocityVector;
  
  color displayColor = color(0,0,0);
  
  ArrayList<PVector> path = new ArrayList<PVector>();
  ArrayList<InfoLine> infoLines = new ArrayList<InfoLine>();
  
  PhysicsObject(float diameter, float mass, PVector pos, boolean staticPos) {
    this.density = mass/(diameter/2);
    this.radius = diameter/2;
    this.mass = mass;
    this.position = pos;
    this.staticPos = staticPos;
    
    velocityVector = new PVector(0,0,0);
    
    displayColor = color(random(255), random(255), random(255));
  }
  
  PhysicsObject(float diameter, float mass, PVector pos, PVector initialVelocity, boolean staticPos) {
    this.density = mass/(diameter/2);
    this.radius = diameter/2;
    this.mass = mass;
    this.position = pos;
    this.velocityVector = initialVelocity;
    this.staticPos = staticPos;
    
    displayColor = color(random(255), random(255), random(255));
  }
  
  void tick() {
    
    //density = mass/area
    //area = pi(radius)^2
    //raduis = sqrt(area/pi)
    //area = density*mass
    
    radius = mass/density;
    
    for(PhysicsObject o:objects) {
      if(o.equals(this))
        continue;
      
      gravity(o);
      if(isColliding(o)){
        if(o.mass > mass) {
          o.mass += mass;
          active = false;
        }
      }
    }
      
    if(!staticPos) {
      position.add(velocityVector);
      path.add(position.copy());
    }
  }
  
  void gravity(PhysicsObject o) {
    PVector directionToObject = new PVector();
        PVector.sub(o.position, position, directionToObject);
        float distance = directionToObject.mag();
        directionToObject.normalize();
        velocityVector.add(directionToObject.mult(
        (gravitationalConstant * (mass * o.mass) / pow(distance, 2)) / mass)
        );
        
        stroke(0,255,0);
        
        //infoLines.add(new InfoLine(position.x, position.y, position.z, position.x + directionToObject.x * 10, position.y + directionToObject.y * 10, position.z + directionToObject.z * 10, color(0,255,0)));
    
        
  }
  
  boolean isColliding(PhysicsObject o) {
    if(dist(o.position.x, o.position.y, position.x, position.y) < o.radius + radius) {
      return true;
    }
    
    return false;
  }
  
  void render() {
    stroke(displayColor);
    strokeWeight(radius*2);
    point(position.x, position.y, position.z);
    push();
    translate(position.x, position.y, position.z);
    sphere(radius);
    pop();
    
    
    strokeWeight(1);
    
    for(InfoLine l: infoLines) {
      l.render();
    }
    infoLines = new ArrayList<InfoLine>();
    stroke(255,0,0);
    line(position.x, position.y, position.z, position.x + velocityVector.x * 10, position.y + velocityVector.y * 10, position.z + velocityVector.z * 10);
    noFill();
    for(int i = 1; i < path.size() - 1; i ++) {
      stroke(red(displayColor), green(displayColor), blue(displayColor), i);
      line(path.get(i).x, path.get(i).y, path.get(i).z, path.get(i+1).x, path.get(i+1).y, path.get(i+1).z);
      
      if(path.size() > 500) {
        path.remove(0);
      }
    }
  }
  
}
