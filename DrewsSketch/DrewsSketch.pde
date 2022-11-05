
int circleY = 100;
int direction = 1;
int speed = 5;

public void setup() {
  size(500,500);
  background(255);
}

public void draw() {
  background(255);
  
  fill(255, 0, 0);
  stroke(0, 255, 0);
  strokeWeight(5);
  circle(100,circleY,50);
  
  circleY += direction * speed;
  
  if(circleY > 475) {
    direction = -1;
  }else if(circleY < 25) {
    direction = 1;
  }
}

public void mouseWheel(MouseEvent event) {
  speed += -event.getCount();
}

public void mousePressed() {
  if(dist(mouseX, mouseY, 100, circleY) < 25) {
    println("Mouse In Circle");
  }
}
