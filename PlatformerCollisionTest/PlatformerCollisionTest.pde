
/*

Known Issues:
  - Fails when hitting the corner of a block at exaclty 45 degrees
    - Using >= <= does not work as it makes bigger problems
    - Probably needs to have context of next point aka lots of extra work
    - After the initial collision, it will resolve to the correct poisition, but takes an extra frame
*/




void setup() {
  size(800,600);
  surface.setResizable(true);
  background(255);
  noFill();
}

Rectangle[] tiles = {new Rectangle(10, 10), new Rectangle(9, 10), new Rectangle(8, 10), new Rectangle(11, 10), new Rectangle(12, 10), new Rectangle(10, 9), new Rectangle(10, 8), new Rectangle(10, 11), new Rectangle(10, 12)};
Rectangle currentRect = new Rectangle(215, 236, 48, 72), nextRect = new Rectangle(0, 0, 48, 72);
float rads = PI/4f;
PVector move = new PVector(30, 30);

boolean debug = true;
int row = 0;

void draw() {
  background(255);
  
  for(Rectangle r: tiles) {
    stroke(#FFA631);
    if(!debug) {
     stroke(0);
     fill(#FFA631);
    }
    rect(r.x, r.y, r.w, r.h);
  }
  
  move = new PVector(50, 0).rotate(rads);
  
  addDebugField("Degrees: " + rads * 180f/PI);
  addDebugField("Move: " + move.toString());
  
  currentRect.x = mouseX;
  currentRect.y = mouseY;
  
  if(!debug) {
    stroke(0);
    fill(#1CD0FF);
    currentRect.draw(false);
  }else {
    stroke(#1CD0FF);
    strokeWeight(3);
    currentRect.draw(false);
    strokeWeight(1);
  }
  
  move();
  
  if(!debug) {
    stroke(0);
    fill(#22D10D);
    nextRect.draw(false);
    noFill();
    stroke(#9611EA);
    rect(currentRect.x + move.x, currentRect.y + move.y, currentRect.w, currentRect.h);
  }else {
    stroke(#22D10D);
    nextRect.draw(false);
    fill(255,0,0);
    text(mouseX + ", " + mouseY, mouseX, mouseY);
    noFill();
  }
  row = 0;
}

public void move() {
  
  //minimum distance to a collision, maximum distance that can be moved
  float minX = move.x;
  float minY = move.y;
  
  
  //find all rects that are directly along the X axis from currentRect in the direction of the move
  
  float checkXx1 = min(currentRect.x, currentRect.x + move.x);
  float checkXy1 = currentRect.y;
  float checkXx2 = max(currentRect.x + currentRect.w, currentRect.x + currentRect.w + move.x);
  float checkXy2 = currentRect.y + currentRect.h;
  
  Rectangle[] checkX = getTiles(checkXx1, checkXy1, checkXx2, checkXy2);
  
  stroke(#FF6150);
  new Rectangle(checkXx1, checkXy1, checkXx2 - checkXx1, checkXy2 - checkXy1).draw(true);
  
  //find the minimum X distance between currentRect and any of these rects
  for(Rectangle r: checkX) {
    stroke(#D029FF);
    r.draw(true);
    if(move.x > 0) {
      if(r.x - (currentRect.x + currentRect.w) < minX) {
        minX = r.x - (currentRect.x + currentRect.w);
      }
    }else {
      if((r.x + r.h) - currentRect.x > minX) {
        minX = (r.x + r.h) - currentRect.x;
      }
    }
  }
  
  //find all rects that are directly along the Y axis from currentRect in the direction of the move
  
  float checkYx1 = currentRect.x;
  float checkYy1 = min(currentRect.y, currentRect.y + move.y);
  float checkYx2 = currentRect.x + currentRect.w;
  float checkYy2 = max(currentRect.y + currentRect.h, currentRect.y + currentRect.h + move.y);
  
  Rectangle[] checkY = getTiles(checkYx1, checkYy1, checkYx2, checkYy2);
  
  stroke(#FF6150);
  new Rectangle(checkYx1, checkYy1, checkYx2 - checkYx1, checkYy2 - checkYy1).draw(true);
  
  //find minimum Y distance between currentRect and any of these rects
  for(Rectangle r: checkY) {
    stroke(#7F7EF5);
    r.draw(true);
    if(move.y > 0) {
      if(r.y - (currentRect.y + currentRect.h) < minY) {
        minY = r.y - (currentRect.y + currentRect.h);
      }
    }else {
      if((r.y + r.h) - currentRect.y > minY) {
        minY = (r.y + r.h) - currentRect.y;
      }
    }
  }
  
  //find all rects then the lines with a vertice in the area between the checkX and checkY rects
  
  float checkCx2 = move.x > 0? max(checkXx2, currentRect.x + currentRect.w) : max(checkXx1, currentRect.x);
  float checkCy2 = move.y > 0? max(checkYy2, currentRect.y + currentRect.h) : max(checkYy1, currentRect.y);
  float checkCx1 = move.x > 0? currentRect.x + currentRect.w : checkXx1;
  float checkCy1 = move.y > 0? currentRect.y + currentRect.h : checkYy1;
  
  float moveLineX1 = move.x > 0? currentRect.x + currentRect.w : currentRect.x;
  float moveLineY1 = move.y > 0? currentRect.y + currentRect.h : currentRect.y;
  float moveLineX2 = moveLineX1 + move.x;
  float moveLineY2 = moveLineY1 + move.y;
  
  Rectangle[] checkCRects = getTiles(checkCx1, checkCy1, checkCx2, checkCy2);
  Line[] checkCLines = getLines(checkCRects, checkCx1, checkCy1, checkCx2, checkCy2);
  
  stroke(#F7FF1C);
  new Rectangle(checkCx1, checkCy1, checkCx2 - checkCx1, checkCy2 - checkCy1).draw(true);
  if(debug)
    line(moveLineX1, moveLineY1, moveLineX2, moveLineY2);
  
  
  //Check collisions between all resultant lines and an imaginary line from corner of currentRect to corner of nextRect
  //Modify appropriate min value dependant on whether colliding line is vertical (minX) or horizontal (minY)
  
  float slopeY = (moveLineY2 - moveLineY1)/(moveLineX2 - moveLineX1);
  float slopeX = (moveLineX2 - moveLineX1)/(moveLineY2 - moveLineY1);
  
  //TODO Algorithm snaps to faces that it shoudln't. FIX Only check the first point along the move line
  
  float cornerMinX = move.x;
  float cornerMinY = move.y;
  float minDist = move.x * move.x + move.y * move.y;
  
  //ArrayList<PVector> collidingPoints = new ArrayList<>();
  //ArrayList<Float> distances = new ArrayList<>();
  
  for(Line l: checkCLines) {
    stroke(#1CFF47);
    l.draw(true);
    strokeWeight(3);
    //check if line is vertical or horizontal
    if(l.p1.x == l.p2.x) {
      //if vertical, find y of moveLine at line.x
      float interX = l.p1.x;
      float horzDist = interX - moveLineX1;
      float interY = moveLineY1 + (slopeY * horzDist);
          
      //check if intersection point lies on line
      if(interY > l.p1.y && interY < l.p2.y) {
        float dist = dist(moveLineX1, moveLineY1, interX, interY);
        if(debug) {
          point(interX, interY);
          fill(255,0,0);
          text(dist, interX, interY);
          noFill();
        }
        
        if(dist < minDist) {
          minDist = dist; //<>//
          if(horzDist < cornerMinX && move.x > 0) {
            cornerMinX = horzDist;
            cornerMinY = move.y;
          }
          if(horzDist > cornerMinX && move.x < 0) {
            cornerMinX = horzDist;
            cornerMinY = move.y;
          }
        }
      }
    }else {
      //if horizontal, find x of moveLine at line.x
      float interY = l.p1.y;
      float vertDist = interY - moveLineY1;
      float interX = moveLineX1 + (slopeX * vertDist); //<>//
            
      //check if intersection point lies on line
      if(interX > l.p1.x && interX < l.p2.x) {
        float dist = dist(moveLineX1, moveLineY1, interX, interY);
        if(debug) {
          point(interX, interY);
          fill(255, 0, 0);
          text(dist, interX, interY);
          noFill();
        }
               
        if(dist < minDist){
          minDist = dist; //<>//
          if(vertDist < cornerMinY && move.y > 0) {
            cornerMinY = vertDist;
            cornerMinX = move.x;
          }
          if(vertDist > cornerMinY && move.y < 0) {
            cornerMinY = vertDist;
            cornerMinX = move.x;
          }
        }
      }
    }
    strokeWeight(1);
  }
  
  //println(cornerMinX + ", " + cornerMinY);
  addDebugField("minDist: " + minDist);
  addDebugField("cornerMinY: " + cornerMinY);
  
  if(cornerMinX < minX && move.x > 0) {
      minX = cornerMinX;
  }
  if(cornerMinX > minX && move.x < 0) {
      minX = cornerMinX;
  }
  if(cornerMinY < minY && move.y > 0) {
    minY = cornerMinY;
  }
  if(cornerMinY > minY && move.y < 0) {
    minY = cornerMinY;
  }
  
  //move rect
  nextRect.x = currentRect.x + minX;
  nextRect.y = currentRect.y + minY;
}

public Line[] getLines(Rectangle[] rects, float x1, float y1, float x2, float y2) {
  ArrayList<Line> temp = new ArrayList<>();
  for(Rectangle r: rects) {
    
    boolean left = r.x >= x1 && r.x <= x2;
    boolean right = r.x + r.w >= x1 && r.x + r.w <= x2;
    boolean top = r.y >= y1 && r.y <= y2;
    boolean bottom = r.y + r.h >= y1 && r.y + r.h <= y2;
    
    if(left && (top || bottom)) {
      temp.add(new Line(r.x, r.y, r.x, r.y + r.h));
    }
    if(right && (top || bottom)) {
      temp.add(new Line(r.x + r.w, r.y, r.x + r.w, r.y + r.h));
    }
    if(top && (left || right)) {
      temp.add(new Line(r.x, r.y, r.x + r.w, r.y));
    }
    if(bottom && (left || right)) {
      temp.add(new Line(r.x, r.y + r.h, r.x + r.w, r.y + r.h));
    }
  }
  
  return temp.toArray(new Line[0]);
}

public Rectangle[] getTiles(float x1, float y1, float x2, float y2) {
  ArrayList<Rectangle> temp = new ArrayList<>();
  for(Rectangle r: tiles) {
    if(r.x < x2 && r.x + r.w > x1 && r.y < y2 && r.y + r.h > y1) {
      temp.add(r);
    }
  }
  return temp.toArray(new Rectangle[0]);
}


public void addDebugField(String data) {
  if(!debug)
    return;
  fill(255,0, 0);
  text(data, 10, (row * 12) + 12);
  row++;
  noFill();
}

public void keyPressed() {
  if(key == 'd') {
    debug = !debug;
  }
}

public void mouseWheel(MouseEvent e) {
  rads += e.getCount() * PI/18f;
}
