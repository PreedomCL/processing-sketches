
int newPixels[];
int genY = 0;
public void setup() {
  size(512,512);
  background(0, 0, 0);
  fill(0);
  strokeWeight(5);
  stroke(255,0,0);
  circle(width/2, height/2, 1);
  stroke(255,0,0);
  //line(0, height/2, width, height/2);
  //line(width/2, 0, width/2, height);
  loadPixels();
  newPixels = new int[width*height];
  
}

public void draw() {
  stroke(255,0,0);
  //line(width/2,0,width/2, genY);
  if(genY < height)
    genY ++;
  loadPixels();
  int headCount = 0;
  for(int i = 0; i < pixels.length; i ++) {
    
    
    float r = red(pixels[i]);
    float g = green(pixels[i]);
    float b = blue(pixels[i]);
    pixels[i] = color(0, 254, 0);
    if(r == 255 && g == 0 && b == 0) {
      
      headCount ++;
      
      try {
        float g1 = green(pixels[i+1]);
        float g2 = green(pixels[i-1]);
        float g3 = green(pixels[i+width]);
        float g4 = green(pixels[i-width]);
        
        boolean r1 = red(pixels[i+1]) == 255;
        boolean r2 = red(pixels[i-1]) == 255;
        boolean r3 = red(pixels[i+width]) == 255;
        boolean r4 = red(pixels[i-width]) == 255;
        //println(r1 || r2 || r3 || r4);
        int d = round(random(g1 + g2 + g3 + g4 + 100));
        if(d > 0 && d <= g1 && !r1) {
          pixels[i+1] = color(255, 0, 0);
        }else if(d > g1 && d <= g1 + g2 && !r2) {
          pixels[i-1] = color(255, 0, 0);
        }else if(d > g1 + g2 && d <= g1 + g2 + g3 && !r3) {
          pixels[i + width] = color(255, 0, 0);
        }else if(d > g1 + g2 + g3 && d <= g1 + g2 + g3 + g4 && !r4) {
          pixels[i - width] = color(255, 0, 0);
        }else {
          int d2 = round(random(4));
          if(d2 == 0 && !r1) {
            pixels[i+1] = color(255, 0, 0);
          }else if(d2 == 1 && !r2) {
            pixels[i-1] = color(255, 0, 0);
          }else if(d2 == 2 && !r3) {
            pixels[i + width] = color(255, 0, 0);
          }else if(d2 == 3 && !r4) {
            pixels[i - width] = color(255, 0, 0);
          }else {
            pixels[i] = color(255, 0, 0);
          }
        }
      } catch(Exception e) {
        pixels[i] = color(255, 0, 0);
      }
      
      if(random(100) < 1) {
        pixels[i] = color(255, 0, 0);
      }
    }else {
      pixels[i] = color(r-1, g-1, b-1);
    }
    
    
  }
  //println(headCount);
  updatePixels();
}
