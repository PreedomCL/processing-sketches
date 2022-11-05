
public void setup() {
  size(1000,800);
}



public void draw() {
  background(255);
  for(float x = -width/2; x < width/2; x += 0.5) {
    line(x+width/2,height-f(x),(x-1)+width/2, height-f(x-1));
  }
  float secX = cos(frameCount/120f)*(width/4f);
  float secY = f(secX);
  
  float derX = 80f;
  float derY = f(derX);
  
  strokeWeight(10);
  fill(255,0,0);
  point(width/2f + derX,height-derY);
  fill(0,255,0);
  point(width/2f + secX,height-secY);
  
  strokeWeight(1);
  
  float m = (secY-derY)/(secX-derY);
  
  line(0, height-pointSlope(secY, secX, m, -width/2f), width,height-pointSlope(secY, secX, m, width/2f));
  
  
}

public float pointSlope(float y1, float x1, float m, float x) {
  return m*(x-x1) + y1;
}

public float f(float x) {
  return pow(x/10f,2f);
}
