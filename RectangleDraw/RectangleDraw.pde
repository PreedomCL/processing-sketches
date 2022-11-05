public void setup() {
  size(800,800);
}

int sX, sY;
boolean drawing = false;
public void draw() {
  if(drawing) {
    rect(min(mouseX, sX), min(mouseY, sY), abs(mouseX-sX), abs(mouseY-sY));
  }
}

public void mouseClicked() {
  drawing = !drawing;
  if(drawing) {
    sX = mouseX;
    sY = mouseY;
  }else {
    background(255);
  }
  
}
