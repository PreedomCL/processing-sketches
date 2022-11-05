public class Entity {
  
  float x, y, w, h;
  PImage texture;
  boolean active = true;
  
  public Entity(int x,int y,int w,int h, PImage texture) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.texture = texture;
  }
  
  void tick() {
    
  }
  
  void render() {
    image(texture,(int) (x - texture.width * 10),(int) (y - texture.height * 10), texture.width * 10, texture.height * 10);
  }
}

public class Player extends Entity {
  
  PVector velocity = new PVector();
  PVector destination = new PVector();
  
  Path path;
  boolean playerControl = true;
  
  int speed = 1;
  int direction;
  
  public Player(int x, int y) {
    super(x, y, 50, 80, assets.player[0]);
    destination = new PVector(x, y);
  }
  
  @Override
  public void tick() {
    super.tick();
    
    move();
    velocity.normalize();
    velocity.mult(speed);
    
    if(velocity.x > 0){
      direction = 0;
    }else if(velocity.x < 0){
      direction = 1;
    }
    
    x += velocity.x;
    y += velocity.y;
  }
  
  public void render() {
    if(assets.player != null){
      image(assets.player[direction], x - (w/2), y - h, w, h);
    }
  }
  
  private void move() {
    
    if(path != null && destination == null) {
      destination = path.getCurrentDestination();
      playerControl = false;
    }
    if(path != null && path.complete) {
      path = null;
      playerControl = true;
    }
    
    if(destination != null && dist(x, y, destination.x, destination.y) > 1 ) {
      velocity.x = destination.x - x;
      velocity.y = destination.y - y;
    }else {
      velocity.mult(0);
      destination = null;
    }
    
    if(path != null && dist(x, y, path.getCurrentDestination().x, path.getCurrentDestination().y) <= 1) {
      path.nextDestination();
    }
    println(playerControl);
  }
  
  public void setPath(Path path) {
    this.path = path;
    playerControl = false;
  }
  
}

public class Checkpoint extends Entity{
  
  int animationIndex = 0;
  int animationSpeed = 10;
  int framesSinceAnimation = 0;
  public Checkpoint(int x,int y) {
    super(x, y, 40, 40, assets.checkpoint[0]);
  }
  
  @Override
  public void tick() {
    super.tick();
    
    framesSinceAnimation ++;
    if(framesSinceAnimation > animationSpeed) {
      framesSinceAnimation = 0;
      animationIndex ++;
      if(animationIndex > assets.checkpoint.length - 1) {
        animationIndex = 0;
      }
    }
  }
  
  @Override
  public void render() {
    image(assets.checkpoint[animationIndex], x - (w/2), y - h, w, h);
  }
}

public class Path {
  
  PVector[] points;
  int pathIndex = 0;
  boolean complete = false;
  boolean repeat;
  public Path(PVector[] points, boolean repeat) {
    this.points = points;
    this.repeat = repeat;
  }
  
  public PVector getCurrentDestination() {
    return points[pathIndex];
  }
  
  public void nextDestination() {
    println("hel");
    if(pathIndex == points.length - 1) {
      if(repeat)
        pathIndex = 0;
      else
        complete = true;
    }else {
      pathIndex ++;
    }
  }
}
