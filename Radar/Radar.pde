

public void setup() {
  size(1000,500);
  background(255);
}

float currentDegree = 0f;
float speed = -PI/360f;
PVector[] polygon = {new PVector(0,5).mult(20), new PVector(1.5,4).mult(20), new PVector(5,4).mult(20), new PVector(1,0).mult(20), new PVector(1,3.5).mult(20)};

public void draw() {
  background(255);
  for (PVector v : polygon) {
    v.x += mouseX - pmouseX;
    v.y += mouseY - pmouseY;
  }
  for(int i = 0; i < 360; i++) {
  currentDegree += speed;
  if(currentDegree < -PI/2f || currentDegree > 0) {
    speed *= -1;
  }
  
  float x2 = 75 + cos(currentDegree)*1000,y2 = 425 + sin(currentDegree)*1000;
  
  ArrayList<PVector> hits = polyLine(polygon, 75, 425, x2, y2);
  PVector closestHit = null;
  if(hits.size() > 0) {
    closestHit = hits.get(0);
    for(PVector hit: hits) {
      point(hit.x, hit.y);
      if(dist(hit.x, hit.y, 75, 245) < dist(closestHit.x, closestHit.y, 75, 245)) {
        closestHit = hit;
      }
    }
  }
  
  //fill(255,1);
  //noStroke();
  //rect(0,0,width,height);
  fill(255,0,0);
  stroke(0);
  strokeWeight(2);
  circle(75,425,50);
  fill(0,0,255);
  //beginShape();
  //for (PVector v : polygon) {
  //  vertex(v.x, v.y);
  //}
  //endShape(CLOSE);
  if(closestHit != null) {
    //circle(closestHit.x, closestHit.y, 10);
  }
  
  stroke(0,255,50);
  //line(75,425, x2, y2);
  }
}

// POLYGON/LINE
ArrayList<PVector> polyLine(PVector[] vertices, float x1, float y1, float x2, float y2) {

  // go through each of the vertices, plus the next
  // vertex in the list
  ArrayList<PVector> hits = new ArrayList();
  int next = 0;
  for (int current=0; current<vertices.length; current++) {

    // get next vertex in list
    // if we've hit the end, wrap around to 0
    next = current+1;
    if (next == vertices.length) next = 0;

    // get the PVectors at our current position
    // extract X/Y coordinates from each
    float x3 = vertices[current].x;
    float y3 = vertices[current].y;
    float x4 = vertices[next].x;
    float y4 = vertices[next].y;

    // do a Line/Line comparison
    // if true, return 'true' immediately and
    // stop testing (faster)
    PVector hit = lineLine(x1, y1, x2, y2, x3, y3, x4, y4);
    if (hit != null) {
      hits.add(hit);
    }
  }
  // never got a hit
  return hits;
}

// LINE/LINE
PVector lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {

  // calculate the distance to intersection point
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

  // if uA and uB are between 0-1, lines are colliding
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {

    // optionally, draw a circle where the lines meet
    float intersectionX = x1 + (uA * (x2-x1));
    float intersectionY = y1 + (uA * (y2-y1));

    return new PVector(intersectionX,intersectionY);
  }
  return null;
}
