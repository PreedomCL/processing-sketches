import java.util.Comparator;
public class Scene {
  
  private Comparator<Entity> renderSorter = new Comparator<Entity>() {
    @Override
    public int compare(Entity a, Entity b) {
      if(a.y + a.h < b.y + b.h)
        return -1;
      return 1;
    }
  };
  
  PImage scene;
  ArrayList<Entity> entities = new ArrayList<Entity>();
  
  public Scene(PImage scene) {
    this.scene = scene;
    entities.add(player);
  }
  
  public void tick() {
    
    for(Entity e:entities) {
      if(!e.active){
        entities.remove(e);
      }else{
        e.tick();
      }
    }
    
    try {
    entities.sort(renderSorter);
    }catch(Exception e) {
      e.printStackTrace();
    }
  }
  
  public void render() {
    image(scene, 0, 0, 640, 960);
    
    for(Entity e: entities) {
      e.render();
    }
  }
}
