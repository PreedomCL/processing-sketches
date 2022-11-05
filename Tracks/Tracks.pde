
ArrayList<PVector> red = new ArrayList();
ArrayList<PVector> blue = new ArrayList();

public void setup() {
  size(1000,600);
  background(255);
}

float cX = 0, cY = 300, rot = 0, radius = 40, fRadius = 50;
public void draw() {
  background(255);
  stroke(0);
  fill(150);
  rect(0, cY+radius, width, (fRadius-radius) * 3);
  fill(100);
  circle(cX, cY, fRadius*2);
  fill(50);
  circle(cX, cY, radius*2);
  
  line(cX - cos(rot)*fRadius, cY - sin(rot)*fRadius, cX + cos(rot)*fRadius, cY + sin(rot)*fRadius);
  noStroke();
  red.add(new PVector(cX + cos(rot)*radius,cY + sin(rot)*radius));
  blue.add(new PVector(cX + cos(rot)*fRadius,cY + sin(rot)*fRadius));
  
  fill(255,0,0);
  for(PVector p: red) {
    circle(p.x, p.y, 3);
  }
  
  fill(0,0,255);
  for(PVector p: blue) {
    circle(p.x, p.y, 3);
  }
  
  rot += PI/180f;
  cX += PI/180f * radius;
}
