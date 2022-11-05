
Assets assets = new Assets();
Scene[] scene = new Scene[10];
Player player;

int sceneIndex = 0;
boolean debug = false;

public void setup() {
  size(640, 960);
  surface.setResizable(true);
  noSmooth();
  
  assets.init();
  
  player = new Player(50,100);
  player.setPath(new Path(new PVector[] {new PVector(50,500), new PVector(500,500)}, false));
  
  scene[0] = new Scene(assets.scene1);
  scene[1] = new Scene(assets.scene2);
  
  scene[0].entities.add(new Checkpoint(100,100));
  
}

public void draw() {
  background(#868d95);
  
  push();  
  translate((width/2) - 320, (height/2) - 480);
  
  scene[sceneIndex].tick();
  scene[sceneIndex].render();
  
  pop();
  
  if(debug)
    debug();
}

public void debug() {

  
  fill(0, 100);
  noStroke();
  rect(mouseX - 5, mouseY - 26, 80, 20);
  fill(0);
  text((mouseX - (width/2) + 320) + ", " + (mouseY - (height/2) + 480), mouseX, mouseY - 10);
  fill(255);
  text((mouseX - (width/2) + 320) + ", " + (mouseY - (height/2) + 480), mouseX, mouseY - 12);
  point(mouseX, mouseY);
  
}

public class Assets {
  
  PImage scene1, scene2, scene3, scene4;
  PImage[] player = new PImage[2], checkpoint = new PImage[8];
  public void init() {
    scene1 = loadImage("scene1.png");
    scene2 = loadImage("scene2.png");
    scene3 = loadImage("scene3.png");
    scene4 = loadImage("scene4.png");
    player = loadAnimation("player", 2);
    checkpoint = loadAnimation("checkpoint", 8);
    
  }
  
  PImage[] loadAnimation(String fileName, int length) {
    PImage[] frames = new PImage[length];
    for(int i = 0; i < length; i++) {
      frames[i] = loadImage(fileName + (i + 1) + ".png");
    }
    return frames;
  }
}

public void mousePressed() {
  
  if(player.playerControl) {
    player.destination = new PVector(mouseX - (width/2) + 320, mouseY - (height/2) + 480);
    player.path = null;
  }
}

public void keyPressed() {
  if(key == 'b') {
    debug = !debug;
  }
}
