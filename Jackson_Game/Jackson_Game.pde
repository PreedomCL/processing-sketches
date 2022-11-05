
ArrayList<Entity> entities = new ArrayList();

public void setup() {
  size(600,600);
  
  entities.add(new Platform(100, 550, 200, 10, color(0,255,0)));
  entities.add(new Player(100,100, color(255,255,0)));
}

public void draw() {
  background(255);
  for(Entity e: entities) {
    e.update();
  }
}
