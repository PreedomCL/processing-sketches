
class FollowingEye {
  
  int x, y, size, pupilSize = 16;
  
  FollowingEye(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void update() {
    
    
    if(dist(mouseX, mouseY, x, y) > (size/2) - pupilSize * 1.5) {
      PVector directionToEyes = new PVector(mouseX - x,mouseY - y).normalize();
      
      directionToEyes.normalize();
      directionToEyes.mult((size/2)-pupilSize * 1.5);
      
      image(eye, x + directionToEyes.x, y + directionToEyes.y, pupilSize, pupilSize);
    }else {
      image(eye, mouseX, mouseY, pupilSize, pupilSize);
    }
    
  }
  
  void onMousePressed() {
    PVector directionToEyes = new PVector(mouseX - x,mouseY - y).normalize();
    
    directionToEyes.normalize();
    directionToEyes.mult((size/2)-pupilSize * 1.5);
    
  
    laserManager.add(new LaserBeam(directionToEyes, new PVector(x + directionToEyes.x, y + directionToEyes.y)));

  }
}
