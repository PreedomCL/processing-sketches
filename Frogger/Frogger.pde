
int x1 = 0, x2 = 0;

public void setup() {
  size(1000,800);
}

public void draw() {
  background(255);
  
  fill(50);
  noStroke();
  rect(0,100,1000,100);
  
  int lineDensity = 50;
  int lineLength = 50;
  for(int x = 0; x < 1000; x += lineLength + lineDensity) {
    stroke(255);
    line(x, 150, x + lineLength, 150);
  }
  
  noStroke();
  fill(255);
  rect(x1, 115, 30, 20);
  rect(x2, 165, 30, 20);
  
  x1 ++;
  x2 --;
  
  if(x1 > 1000) {
    x1 = -30;
  }
  
  if(x2 < -30) {
    x2 = 1000;
  }
  
}
