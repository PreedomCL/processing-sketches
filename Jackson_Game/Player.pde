public class Player extends Creature{
  
  
  public Player(float x, float y, color c) {
    super(x, y, 50, 50, c);
  }
  
  @Override
  public void update() {
    super.update();
    
    if(keyPressed) {
      switch(key) {
        case 'w':
          addForce(0, -1);
          break;
        case 's':
          addForce(0,1);
          break;
        case 'a':
          addForce(-1,0);
          break;
        case 'd':
          addForce(1,0);
          break;
      }
    }
  }
  
}
