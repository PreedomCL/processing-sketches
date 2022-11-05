
ArrayList<Particle> particles = new ArrayList();
float gravityForce = 5;

public void setup() {
  size(1000,800);
  particles.add(new Particle(100,100,10, new PVector(0,0)));
}

public void draw() {
  background(255);
  for(Particle p: particles) {
    p.update();
  }
}
