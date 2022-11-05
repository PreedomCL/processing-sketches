
long lastTime;
public void setup() {
  
  size(1000,800, P3D);
  background(255);
  
}

public PVector translation = new PVector(0,0,0);
public float speed = 0.05;
public float detail = 10;
public float size = 100;

public void draw() {
  background(255);
  push();
  translate(width/2,height/2,0);
  rotateX(translation.x);
  rotateY(translation.y);
  rotateZ(translation.z);
  
  //for(float outerRad = 0; outerRad < 2*PI; outerRad += (1f/4f)*(1f/12f)*(1f/detail)*2f*PI) {
    
  //  float radius = cos(outerRad)*size*10;
  //  float h = sin(outerRad)*size;
  //  for(float rad = 0; rad < 2*PI; rad += (1f/4f)*(1f/12f)*(1f/detail)*2f*PI) {
  //    strokeWeight(2);
  //    point(cos(rad)*radius, h, sin(rad)*radius);
  //  }
  //}
  
  for(float rad = 0; rad < 2*PI; rad += (1f/4f)*(1f/12f)*(1f/detail)*2f*PI) {
      strokeWeight(2);
      point(cos(rad)*100, tan(rad)*100, sin(rad)*100);
  }
  
  pop();
  fill(255,0,0);
  text(1000/(System.currentTimeMillis() - lastTime), 0, 16);
  lastTime = System.currentTimeMillis();
  
  //box(100);
  
  if(keyPressed) {
    if(key == 'w') {
      translation.add(new PVector(-1 * speed,0,0));
    }else if(key == 's') {
      translation.add(new PVector(1 * speed,0,0));
    }else if(key == 'a') {
      translation.add(new PVector(0,-1 * speed,0));
    }else if(key == 'd') {
      translation.add(new PVector(0,1 * speed,0));
    }else if(key == 'q') {
      translation.add(new PVector(0, 0, -1 * speed));
    }else if(key == 'e') {
      translation.add(new PVector(0, 0, 1 * speed));
    }else if(key =='i') {
      size ++;
    }else if(key == 'o') {
      size --;
    }
  }
  
}
