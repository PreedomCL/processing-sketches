void setup() {
  size(1000,800);
  createBalls(10);
  //balls.add(new Ball(1, 950, 400, -5, 0, 50, color(255, 0, 0)));
  //balls.add(new Ball(2, 130, 400, 0, 0, 20, color(0, 0, 255)));
  //balls.add(new Ball(3, 90, 400, 0, 0, 20, color(0, 0, 255)));
  //balls.add(new Ball(4, 50, 400, 0, 0, 20, color(0, 0, 255)));
  //balls.add(new Ball(500, 750, 0, 0, 50, color(255, 0, 0)));
  //balls.add(new Ball(590, 50, 0, 0, 50, color(0, 0, 255)));
}

ArrayList<Ball> balls = new ArrayList();

void draw() {
  background(255);
  
  float energy = 0;
  for(int i = 0; i < balls.size(); i++) {
    balls.get(i).tick();
  }
  for(int i = 0; i < balls.size(); i++) {
    energy += balls.get(i).v.mag() * balls.get(i).r * balls.get(i).r * PI;
  }
  fill(0);
  text(energy, 60, 10);
}

void mouseClicked() {
  createBall(mouseX, mouseY);
}

void keyPressed() {
  loop();
}

void createBalls(int n) {
  for(int i = 0; i < n; i++) {
    balls.add(new Ball(balls.size(), random(100,width-100), random(100, height-100), random(-5, 5), random(-15,25), (int)random(20, 50), color(random(0,255), random(0,255), random(0,255))));
  }
}

void createBall(int x, int y) {
   balls.add(new Ball(balls.size(), x, y, random(-5, 5), random(-15,25), (int)random(50, 100), color(random(0,255), random(0,255), random(0,255))));
}
