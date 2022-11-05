float detail = 5;

PVector[] bigTri;
PVector lastPoint;

public void setup() {
  size(1000,900);
  
  bigTri = trianglePointsFromCentroid(new PVector(width/2, height/2), 1000);
  
  float r1 = random(1);
  float r2 = random(1);
  
  PVector firstPoint = new PVector();
  firstPoint.x = (1 - sqrt(r1)) * bigTri[0].x + (sqrt(r1) * (1 - r2)) * bigTri[1].x + (sqrt(r1) * r2) * bigTri[2].x;
  firstPoint.y = (1 - sqrt(r1)) * bigTri[0].y + (sqrt(r1) * (1 - r2)) * bigTri[1].y + (sqrt(r1) * r2) * bigTri[2].y;
  
  background(255);
  
  stroke(1);
  
  drawTriangle(bigTri);
  drawTriangle(trianglePointsFromCentroid(firstPoint, 5));
  lastPoint = firstPoint;
}
int k;
public void draw() {
  
  for(int i = 0; i < 1000; i ++) {
    k++;
    int random = floor(random(3));
    PVector newPoint = new PVector(lastPoint.x-(lastPoint.x-bigTri[random].x)/2, lastPoint.y - (lastPoint.y-bigTri[random].y)/2);
    noStroke();
    fill(0,0,0);
    drawTriangle(trianglePointsFromCentroid(newPoint, 3));
    lastPoint = newPoint;
  }
}

public PVector[] trianglePointsFromCentroid(PVector centroid, float sideLength) {
  
  PVector[] points = new PVector[3];
  points[0] = new PVector(centroid.x, centroid.y + ((sqrt(3f)/3f))*sideLength);
  points[1] = new PVector(centroid.x - (sideLength/2f), centroid.y - ((sqrt(3f)/6f)*sideLength));
  points[2] = new PVector(centroid.x + (sideLength/2f), centroid.y - ((sqrt(3f)/6f)*sideLength));
  
  return points;
}

public void drawTriangle(PVector[] points) {
  triangle(points[0].x, points[0].y, points[1].x, points[1].y, points[2].x, points[2].y);
}
