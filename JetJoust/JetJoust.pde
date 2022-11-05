

public void setup() {
  size(1500,900);
}

Player player1 = new Player(100,100,color(255,0,0));

public void draw() {
  background(255);
  player1.update();
}
