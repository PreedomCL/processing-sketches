
PImage face;
PImage sadFace;
PImage eye;
PImage baddy;

PFont font;
LaserManager laserManager = new LaserManager();
BaddyManager baddyManager = new BaddyManager();
int score = 0;
int diffuculty;
int cooldown = 0;
boolean gameOver = false;
boolean spawnBaddies = false;
void setup() {
  frameRate(10);
  size(800,800);
  
  face = loadImage("SmileyFace.png");
  sadFace = loadImage("FrownyFace.png");
  eye = loadImage("Eye.png");
  baddy = loadImage("Baddy.png");
  
  font = loadFont("AgencyFB-Bold-48.vlw");
  textFont(font);
  noSmooth();
}

FollowingEye eye1 = new FollowingEye(346,368,80);
FollowingEye eye2 = new FollowingEye(458,368,80);
 
void draw() {
  background(255);
  imageMode(CENTER);
  
  if(!gameOver) {
    image(face, 400, 400, 256, 256);
  }else {
    image(sadFace, 400, 400, 256, 256);
  }
  eye1.update();
  eye2.update();
  
  if(mousePressed && cooldown < 1) {
    cooldown = 2;
    if(!gameOver) {
      eye1.onMousePressed();
      eye2.onMousePressed();
    }
  }
  cooldown --;
  
  if(!gameOver) {
    laserManager.update();
    baddyManager.update();
  }
  
  textAlign(CENTER, CENTER);
  fill(0);
  textSize(40);
  text(score, 399, 103);
  fill(255, 255, 0);
  text(score, 400, 100);
  fill(0, 100);
  
  
  if(gameOver) {
    fill(200, 0, 0);
    text("Game Over", 400, 200);
    textSize(20);
    text("Press Space to Try Again", 400, 244);
  }
}

void mousePressed() {
  if(!gameOver) {
    eye1.onMousePressed();
    eye2.onMousePressed();
  }
}

void keyPressed() {
  if(key == ' ' && gameOver) {
    gameOver = false;
    score = 0;
    baddyManager.baddies = new ArrayList<Baddy>();
    laserManager.lasers = new ArrayList<LaserBeam>();
    frameCount = 0;
  }
  if(key == ' ' && !spawnBaddies) {
    frameCount = 0;
    spawnBaddies = true;
  }
}

// LINE/CIRCLE
boolean lineCircle(float x1, float y1, float x2, float y2, float cx, float cy, float r) {

  // is either end INSIDE the circle?
  // if so, return true immediately
  boolean inside1 = pointCircle(x1,y1, cx,cy,r);
  boolean inside2 = pointCircle(x2,y2, cx,cy,r);
  if (inside1 || inside2) return true;

  // get length of the line
  float distX = x1 - x2;
  float distY = y1 - y2;
  float len = sqrt( (distX*distX) + (distY*distY) );

  // get dot product of the line and circle
  float dot = ( ((cx-x1)*(x2-x1)) + ((cy-y1)*(y2-y1)) ) / pow(len,2);

  // find the closest point on the line
  float closestX = x1 + (dot * (x2-x1));
  float closestY = y1 + (dot * (y2-y1));

  // is this point actually on the line segment?
  // if so keep going, but if not, return false
  boolean onSegment = linePoint(x1,y1,x2,y2, closestX,closestY);
  if (!onSegment) return false;

  // optionally, draw a circle at the closest
  // point on the line
  // get distance to closest point
  distX = closestX - cx;
  distY = closestY - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  if (distance <= r) {
    return true;
  }
  return false;
}


// POINT/CIRCLE
boolean pointCircle(float px, float py, float cx, float cy, float r) {

  // get distance between the point and circle's center
  // using the Pythagorean Theorem
  float distX = px - cx;
  float distY = py - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the circle's
  // radius the point is inside!
  if (distance <= r) {
    return true;
  }
  return false;
}


// LINE/POINT
boolean linePoint(float x1, float y1, float x2, float y2, float px, float py) {

  // get distance from the point to the two ends of the line
  float d1 = dist(px,py, x1,y1);
  float d2 = dist(px,py, x2,y2);

  // get the length of the line
  float lineLen = dist(x1,y1, x2,y2);

  // since floats are so minutely accurate, add
  // a little buffer zone that will give collision
  float buffer = 0.1;    // higher # = less accurate

  // if the two distances are equal to the line's
  // length, the point is on the line!
  // note we use the buffer here to give a range,
  // rather than one #
  if (d1+d2 >= lineLen-buffer && d1+d2 <= lineLen+buffer) {
    return true;
  }
  return false;
}
