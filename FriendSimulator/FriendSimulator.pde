


PImage start;
PImage right[] = new PImage[6];
PImage left[] = new PImage[6];
PImage death[]= new PImage[6];
PImage background; 
int x = 500;
int animSpeed = 5;
int animStage = 0;
char direction = 's';

public void setup() {
  size(1000,700);
  start = loadImage("/Ghost-Character/ghost_start.png");
  background = loadImage("forest.jpg");
  for(int i = 0; i < 6; i ++) {
    right[i] = loadImage("/Ghost-Character/ghost_right_run_" + i + ".png");
    left[i] = loadImage("/Ghost-Character/ghost_left_run_" + i + ".png");
    death[i] = loadImage("/Ghost-Character/ghost_right_death_" + i + ".png");
  }
}

public void draw() {
  background(255);
  image(background,-100,-100);
  noStroke();
  fill(#93843A);
  rect(0,550,1000,150);
  if(direction == 's') {
    image(start, x, 350);
  }else if(direction == 'l') {
    image(left[animStage / animSpeed], x, 350);
  }else if(direction == 'r') {
    image(right[animStage / animSpeed], x, 350);
  }else if(direction == 'd') {
    image(death[animStage / animSpeed], x, 350);
  }
  
  if(key == 'a') {
    direction = 'l';
    x --;
    animStage ++;
  }else if (key == 'd') {
    direction = 'r';
    x ++;
    animStage ++;
  }else if (key == ' ') {
    if(direction != 'd') {
      direction = 'd';
      animStage = 0;
    }
  }
  
  if(direction == 'd') {
    animStage ++;
  }
  
  if(animStage > 5 * animSpeed) {
    if(direction == 'd') {
      fill(255);
      text("You commited die on your friend", 500,350);
      noLoop();
    }
    animStage = 0;
  }
}

public void keyReleased() {
  key = 'w';
}
