
float x1 = 100, y1 = 140, x2 = 300, y2 = 100;
PVector velocity1 = new PVector(0,20), velocity2;
float launchAngle = radians(51.818f);
float speed = 0.05;

public void setup() {
  size(1000,800);
  velocity2 = new PVector(cos(launchAngle)*-30, sin(launchAngle)*30);
}

public void draw() {
  //background(255);
  noStroke();
  fill(255,0,0);
  circle(x1, y1, 10);
  fill(0,0,255);
  circle(x2, y2, 10);
  
  x1 += velocity1.x*speed;
  y1 += velocity1.y*speed;
  x2 += velocity2.x*speed;
  y2 += velocity2.y*speed;
  
}
