
ArrayList<Entity> entities = new ArrayList<Entity>();
float gravity = 1;
public void setup() {
  size(1000,700);
  entities.add(new StaticEntity(100,500,100,10));
  entities.add(new Creature(100,100,10,10));
}

public void draw() {
  
  //ArrayList<Entity> updatedEntities = (ArrayList)entities.clone();
  background(255);
  for(Entity e :entities) {
    e.tick();
    e.render();
    if(!e.isActive()) {
      entities.remove(e);  
    }
  }
}
