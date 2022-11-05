
int cx = 250;
int cy = 250;

int xOffset = 0;
int yOffset = 0;
float scale = 1;

PhysicsObject target;
int targetIndex = -1;

float gravitationalConstant = 0.05;
ArrayList<PhysicsObject> objects = new ArrayList<PhysicsObject>();

int timeScale = 60;
int time = 0;
boolean running = false;
void setup() {
  size(800,800);
  surface.setTitle("Gravity Sim");
  surface.setResizable(true);
  frameRate(timeScale);
  
  //Uncomment these for a functional(ish) solar system. Make sure to comment out the for() loop down below!
  objects.add(new PhysicsObject(10, 1000f, new PVector(800,300), new PVector(0,-1), false));
  objects.add(new PhysicsObject(10, 1000f, new PVector(900,300), new PVector(0,-1), false));
  objects.add(new PhysicsObject(10, 5000f, new PVector(-500,300), new PVector(0,-1), false));
  objects.add(new PhysicsObject(10, 10000f, new PVector(700,400), new PVector(0,-4.5), false));
  objects.add(new PhysicsObject(100, 100000f, new PVector(400,400), false));
  //objects.add(new PhysicsObject(100, 10000000f, new PVector(0,0), false));
  
  //This will generate 200 random objects, just for fun!
  //for(int i = 0; i < 200; i++) {
  //  objects.add(new PhysicsObject(10, random(1000, 100000), new PVector(random(-10000,10000),random(-10000,10000)), false));
  //}
  
  //You can add your own objects by typing objects.add(new PhysicsObject(diameter, mass, new PVector(startingX, startingY), new PVector(initalXVelocity, initalYVelocity) (Optional), staticPos?)
  
}

void draw() {
  background(0);
  
  if(running)
    time++;
  
  if(mousePressed) {
    if(mouseX != pmouseX || mouseY != pmouseY) {
      target = null;
      targetIndex = -1;
    }
    
    xOffset += (mouseX - pmouseX)/scale;
    yOffset += (mouseY - pmouseY)/scale;
  }
  
  push();
  scale(scale);
  translate(xOffset, yOffset);
  
  for(int i = 0; i < objects.size(); i++) {
    PhysicsObject o = objects.get(i);
    if(!o.active) {
      objects.remove(o);
      continue;
    }
    if(running) {
      o.tick();
    }
    o.render();
  }
  pop();
  
  fill(255,0,0);
  text("TPS: " + frameRate, 50,50);
  text("Time: " + time, 50,64);
  text("Objects: " + objects.size(), 50, 78);
  
  if(target != null){
    //float targetX = (int)-(target.position.x - (width/scale)/2) * scale;
    //float targetY = (int)-(target.position.y - (height/scale)/2) * scale;
    
    float targetX = (int)-((target.position.x) - ((width)/2)/scale);
    float targetY = (int)-((target.position.y) - ((height)/2)/scale);
    xOffset += (int)((targetX - xOffset) * min(max((target.velocityVector.mag() / 10), 0.2), 0.5));
    yOffset += (int)((targetY - yOffset) * min(max((target.velocityVector.mag() / 10), 0.2), 0.5));
    
    text("Density " + target.density, width - 300, height - 148);
    text("Mass: " + target.mass, width - 300, height - 124);
    text("Coordinates: " + target.position, width - 300, height - 100);
    text("Velocity: " + target.velocityVector, width - 300, height - 76);
    text("Speed: " + target.velocityVector.mag() + " u/t", width - 300, height - 52);
    
    
  }
  text(((mouseX/scale) - xOffset) + "," + ((mouseY/scale) - yOffset) + "|Scale: " + scale, mouseX, mouseY);
  text("Instructions: \nUse Scroll Wheel to zoom \nuse LMB to pan and inspect objects \npress space to start/stop simulaiton \nuse left and right arrow keys to inspect objects \nedit start() method to change what objects are in the scene", 50, 700);
}

void keyPressed() {
  
  if(keyCode == LEFT) {
    if(targetIndex > 0) {
      targetIndex --;
    }
  }else if(keyCode == RIGHT) {
    if(targetIndex < objects.size() - 1) {
      targetIndex ++;
    }
  }else if(keyCode == DOWN) {
    targetIndex = -1;
  }
  
  if(key == ' ') {
    running = !running;
  }
  
  if(targetIndex == -1) {
    target = null;
  }else {
    target = objects.get(targetIndex);
    //scale = 1;
  }
  
  if(key == '=' && timeScale < 200) {
    timeScale += 10;
    frameRate(timeScale);
  }else if(key == '-' && timeScale > 10) {
    timeScale -= 10;
    frameRate(timeScale);
  }
}

void mouseWheel(MouseEvent event) {
  //target = null;
  //targetIndex = -1;
  float zoom = 0;
  if(event.getCount() > 0) {
    zoom = 0.9;
  }else if(event.getCount() < 0 ) {
    zoom = 1.1;
  }
  
  if(target == null) {
    xOffset += (mouseX/(scale * zoom)) - (mouseX/scale);
    yOffset += (mouseY/(scale * zoom)) - (mouseY/scale);
  }
  
  scale *= zoom;
}
public void mousePressed() {
  for(PhysicsObject o:objects) {
    if(dist(((mouseX/scale) - xOffset), ((mouseY/scale) - yOffset), o.position.x, o.position.y) < o.radius) {
      target = o;
    }
  }
}
