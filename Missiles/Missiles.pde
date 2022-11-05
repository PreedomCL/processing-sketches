
//Curtis Preedom
//5-19-22

PVector target = new PVector(100,100), projectile = new PVector(600,300);
PVector targetV = new PVector(0,3*20), projectileV = new PVector(100f,0);

public void setup() {
  frameRate(60);
  size(1000,800);
  
  PVector result = findIntersection(new PVector(0f,0f), new PVector(-2f,6f), atan(2f), 0);
  
  if(result == null) {
    println("lines are parallel");
  }else {
    println("(" + result.x + "," + result.y + ")");
  }
  
  PFont mono = loadFont("Monospaced.plain-12.vlw");
  textFont(mono);
}

float currentTime = 0;
float currentIncrement = 2;
float lastTimeScore = 0;
int checks = 0;


public void draw() {
  background(255);
  
  for(int i = 0; i < 1; i ++) {
  float[] result = calcTimeScore(target, targetV, projectile, projectileV.mag(), currentTime);
  if(lastTimeScore != 0) {
    if((lastTimeScore > 0) != (result[0] > 0)) {
      if(abs(currentIncrement) < 0.01) {
        currentIncrement = 0;
      }else {
        currentIncrement *= -0.1;
      }
    }
  }
  
  lastTimeScore = result[0];
  currentTime += currentIncrement;
  
  if(currentIncrement == 0) {
    checks = 0;
    projectile.add(PVector.mult(projectileV, 0.1));
    target.add(PVector.mult(targetV, 0.1));
    currentTime = 0;
    currentIncrement = 2;
    lastTimeScore = 0;
  }else {
    checks++;
  }
  
  //if(keyPressed && keyCode == UP) {
  //  currentTime += .1f;
  //}else if (keyPressed && keyCode == DOWN) {
  //  currentTime -= .1f;
  //}
  
  float pMag = projectileV.mag();
  projectileV.x = cos(result[1])*pMag;
  projectileV.y = sin(result[1])*pMag;
  
  //display
  stroke(0,0,255);
  fill(0, 0,200);
  circle(target.x, target.y, 10);
  line(target.x, target.y, target.x + targetV.x, target.y + targetV.y);
  stroke(255,0,0);
  fill(200, 0,0);
  circle(projectile.x, projectile.y, 10);
  
  fill(255,0,0);
  text("Time Difference: " + result[0] + " Angle:" + degrees(result[1]) + " Checks:" + checks, 10, 10);
  line(projectile.x, projectile.y, projectile.x + projectileV.x, projectile.y + projectileV.y);
  }
  
}

public float[] calcTimeScore(PVector tPos, PVector tVel, PVector pPos, float pSpeed, float time) {
  PVector intersection = PVector.add(tPos,PVector.mult(tVel,time));
  float pTime = intersection.dist(pPos)/pSpeed;
  float distY = intersection.y - pPos.y, distX = intersection.x - pPos.x;
  float pAngle = -1;
  if(distY >= 0 && distX > 0) {
    pAngle = atan(distY/distX);
  }else if(distY >= 0 && distX < 0 || distY < 0 && distX < 0) {
    pAngle = atan(distY/distX) + PI;
  }else if(distY < 0 && distX > 0) {
    pAngle = atan(distY/distX) + 2*PI;
  }else if(distX == 0) {
    pAngle = (distY > 0)? PI/2f : 3f*PI/2f;
  }
  
  stroke(0,200,0);
  fill(0,255,0);
  circle(intersection.x, intersection.y, 5);
  
  return new float[] {time-pTime, pAngle};
}

public float calcAngleScore(PVector tPos, PVector tVel, PVector pPos, float pSpeed, float checkAngle) {
  
  float tAngle = atan(tVel.y/tVel.x);
  PVector intersection = findIntersection(tPos, pPos, tAngle, checkAngle);
  if(intersection == null) {
    return -1;
  }
  
  stroke(0,200,0);
  fill(0,255,0);
  circle(intersection.x, intersection.y, 5);
  
  float tTime = tPos.dist(intersection)/tVel.mag();
  float pTime = pPos.dist(intersection)/pSpeed;
  
  return tTime-pTime;
  
}

public PVector findIntersection(PVector p1, PVector p2, float angle1, float angle2) {
  if(angle1 == angle2) {
    return null;
  }
  if(cos(angle1) == 0) {
    //Line 1 is vertical
    float hitY = tan(angle2)*(p1.x-p2.x)+p2.y;
    return new PVector(p1.x, hitY);
  }
  if(cos(angle2) == 0) {
    //Line 2 is vertical
    float hitY = tan(angle1)*(p2.x-p1.x)+p1.y;
    return new PVector(p2.x, hitY);
  }
  
  
  /*
  Works for any two linear equations given that neither are vertical
  y1 - m1 * x1 = b1
  y2 - m2 * x2 = b2
  
  Using elementary matrix operations (gauss-jordan-elimination):
  [1 -m1 b1] -> [1    -m1      b1    ]         ->         [1  0 b1+bb*(m1/mm)]
  [1 -m2 b2]    [0 -m2-(-m1) b2+(-b1)] mm=-m2+m1 bb=b2-b1 [0 mm     bb       ]
  */
  
  float m1, b1, m2, b2;
  m1 = tan(angle1);
  b1 = -(m1*p1.x) + p1.y;
  m2 = tan(angle2);
  b2 = -(m2*p2.x) + p2.y;
  
  float hitY, hitX;
  hitY = b1 + (-b1+b2)*(m1/(-m2+m1));
  hitX = (-b1+b2)/(-m2+m1);
  
  return new PVector(hitX, hitY);
}
