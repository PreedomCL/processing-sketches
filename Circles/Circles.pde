PImage image;
ArrayList<Circle> circles = new ArrayList<Circle>();
long lastTime;
int lmouseX = 0, lmouseY = 0;
public void setup() {
  size(1024,512);
  background(255);
  circles.add(new Circle(256, 256, 256));
  //circles.add(new Circle(256 + 512, 256 + 512, 256));
  lastTime = System.currentTimeMillis();
  image = loadImage("globe.jpg");
  image.resize(512, 512);
  image.loadPixels();
}

public void draw() {
  background(255);
  image(image, 512, 0);
  for(Circle c:circles) {
    c.update();
  }
  for(int i = 0; i < circles.size(); i ++) {
    if(!circles.get(i).isActive()) {
      circles.remove(i);
    }
  }
  fill(255,0,0);
  text(1000/(System.currentTimeMillis() - lastTime), 0, 16);
  lastTime = System.currentTimeMillis();
}

public void mouseMoved() {
  if(dist(lmouseX, lmouseY, mouseX, mouseY) > 10) {
    for(int i = 0; i < circles.size(); i ++) {
      circles.get(i).checkMouseMove();
    }
  }
}

public class Circle {
  
  int x, y;
  float r;
  boolean mouseOn = false, active = true;
  color c;
  public Circle(int x, int y, float r) {
    this.x = x;
    this.y = y;
    this.r = r;
    c = findColorAverage();
  }
  
  public void update() {
    fill(c);
    circle(x, y, r * 2);
  }
  
  public void checkMouseMove() {
    if(dist(mouseX, mouseY, x, y) < r) {
       if(!mouseOn && r > 2) {
         circles.add(new Circle((int)(x-(r/2)), (int)(y-(r/2)), r/2));
         circles.add(new Circle((int)(x-(r/2)), (int)(y+(r/2)), r/2));
         circles.add(new Circle((int)(x+(r/2)), (int)(y-(r/2)), r/2));
         circles.add(new Circle((int)(x+(r/2)), (int)(y+(r/2)), r/2));
         active = false;
         mouseOn = true;
         lmouseX = mouseX;
         lmouseY = mouseY;
       }
    }else {
      mouseOn = false;
    }
  }
  
  public boolean isActive() {
    return active; 
  }
  
  public color findColorAverage() {
    image.loadPixels();
    int red = 0;
    int green = 0;
    int blue = 0;
    
    for(int pixelX = x-(int)r; pixelX < x+r; pixelX++) {
      for(int pixelY = y-(int)r; pixelY < y+r; pixelY++) {
        println(x + ", " + y);
        int intColor = image.pixels[x + (512 * y)];
        red += red(intColor);
        green += green(intColor);
        blue += blue(intColor);
      }
    }
    
    return color(red/(r*2*r*2), green/(r*2*r*2), blue/(r*2*r*2));
  }
}
