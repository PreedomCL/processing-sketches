class Baddy {
  boolean alive = true;
  PVector position, direction;
  Baddy(int x, int y, PVector direction) {
    this.position = new PVector(x, y);
    this.direction = direction;
    direction.normalize();
    direction.mult(diffuculty * 1.5);
  }
  
  void update() {
    image(baddy, position.x, position.y, 32, 32);
    position.add(direction);
    checkCollision();
  }
  
  void checkCollision() {
    for(LaserBeam l:laserManager.lasers) {
      if(lineCircle(l.start.x, l.start.y, l.end.x, l.end.y, position.x, position.y, 32)) {
        alive = false;
        score++;
        return;
      };
    }
    
    if(dist(position.x, position.y, 400, 400) < 128) {
      gameOver = true;
    }
  }
}

class BaddyManager {
  ArrayList<Baddy> baddies = new ArrayList<Baddy>();
  BaddyManager() {
  
  }
  
  void addBaddy(Baddy b) {
    baddies.add(b);
  }
  
  void update() {
    for(int i = 0; i < baddies.size(); i ++) {
      if(!baddies.get(i).alive) {
        baddies.remove(i);
      }
    }
    for(Baddy b:baddies) {
      b.update();
      
    }
    if(spawnBaddies) {
      spawnBaddy();
    }
  }
  
  void spawnBaddy() {
    
    
    if(frameCount < 1000) {
      diffuculty = (frameCount/200) + 3;
    }else {
      diffuculty = 8;
    }
    println(diffuculty);
    if(random(0, 10) > diffuculty) {
      return;
    }
    
    int spawnX = (int)random(-100, 900), spawnY = (int)random(-100, 900);
    if(spawnX > 0 && spawnX < 400) {
      spawnX = -32;
    }else if(spawnY > 0 && spawnY < 400) {
      spawnY = -32;
    }
    
    if(spawnX >= 400 && spawnX < 800) {
      spawnX = 832;
    }else if(spawnY >= 400 && spawnY < 800) {
      spawnY = 832;
    }
    PVector direction = new PVector(400 - spawnX, 400 - spawnY);
    
    addBaddy(new Baddy(spawnX, spawnY, direction));
  }
}
