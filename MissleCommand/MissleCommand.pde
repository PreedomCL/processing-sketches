
int launchCooldown = 0;
boolean missileReady = true, gameOver = false;
ArrayList<Missile> missiles = new ArrayList<Missile>();
ArrayList<DamageCloud> damageClouds = new ArrayList<DamageCloud>();
public void setup() {
  size(800,800);
}

public void draw() {
  noStroke();
  background(255);
  fill(100, 150, 100);
  rect(0,700,800,100);
  fill(100,100,150);
  rect(100,650,100,50);
  rect(600,650,100,50);
  rect(350,650,100,50);
  
  for(int i = 0; i < damageClouds.size(); i ++) {
    damageClouds.get(i).update();
    if(damageClouds.get(i).isMaxRaduisReached()) {
      damageClouds.remove(i);
    }
  }
  
  for(int i = 0; i < missiles.size(); i ++) {
    missiles.get(i).update();
    if(!missiles.get(i).active) {
      missiles.remove(i);
    }
  }
  
  if(launchCooldown <= 0 && !gameOver) {
    missiles.add(new EnemyMissile(1));
    launchCooldown = 180;
  }
  launchCooldown --;
  if(gameOver) {
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255,0,0);
    text("Game Over", 400, 400);
  }
}

public void mousePressed() {
  if(missileReady) {
    missiles.add(new PlayerMissile(mouseX, mouseY));
    missileReady = false;
  }
}
