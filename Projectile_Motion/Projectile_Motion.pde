void setup() {
  size(1000,800);
  noStroke();
}

float initX = 0f, initY = 10f;
float x = initX, y = initY;
float initSpeed = 377f;
float launchAngle = PI/4f;
float g = 385.8f;

PVector initVelocity = new PVector(cos(launchAngle)*initSpeed, sin(launchAngle)*initSpeed);
PVector velocity = initVelocity;
float scale = 0.001f;
float time = 0f;

void draw() {
  background(255);
  fill(255,0,0);
  //circle(x, height - y, 10);
  
  //apply velocity
  x += velocity.x * scale;
  y += velocity.y * scale;
  
  //accelerate velocity
  velocity.y -= g * scale;
  
  fill(0,0,255);
  float tX = initX + initVelocity.x * time;
  float tY = initY + initVelocity.y * time + -0.5f*g*pow(time,2);
  circle(tX*5, height - tY*5, 5);
  println(tX, ", " + tY);
  stroke(0);
  //line(tX,0,tX,height);
  
  time += scale;
}
