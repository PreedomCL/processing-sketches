
public static class Collision {
  
  public static boolean rectRect(float r1x,float r1y,float r1w,float r1h,float r2x,float r2y,float r2w,float r2h) {
    if (r1x + r1w >= r2x && r1x <= r2x + r2w && r1y + r1h >= r2y && r1y <= r2y + r2h) {    
      return true;
    }
    return false;
  }
  
  public static boolean lineLine(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  
    // calculate the distance to intersection point
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    return (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1);
  }
  
  public static PVector lineLineIntersection(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  
    // calculate the distance to intersection point
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));

    // if uA and uB are between 0-1, lines are colliding
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      return new PVector(x1 + (uA * (x2-x1)), y1 + (uA * (y2-y1)));
    }
    return new PVector(0,0);
  }
}

public class BoundingBox {
  int x, y, w, h;
  public BoundingBox(int realativeX, int realativeY, int w, int h) {
    x = realativeX;
    y = realativeY;
    this.w = w;
    this.h = h;
  }

  public boolean intersects(BoundingBox b) {
    float r1x = x;
    float r1y = y;
    float r1w = w;
    float r1h = h;
    
    float r2x = b.getX();
    float r2y = b.getY();
    float r2w = b.getW();
    float r2h = b.getH();
    return(Collision.rectRect(r1x, r1y, r1w,r1h,r2x,r2y,r2w,r2h));
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }

  public int getW() {
    return w;
  }

  public int getH() {
    return h;
  }
}
