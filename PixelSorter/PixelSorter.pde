
boolean finished = false;
public void setup() {
  size(512,512);
  //loadPixels();
  //for(int i = 0; i < pixels.length; i ++) {
  //  pixels[i] = (int)color(random(255), random(255), random(255));
  //}
  //updatePixels();
  PImage image = loadImage("treeonlake.jpg");
  image(image, 0,0, width, height);
  loadPixels();
}

public void draw() {
  if(!finished) {
    finished = true;
    for(int r = 0; r < 100; r ++) {
      int changes = 0;
      for(int i = 0; i < pixels.length - 1; i ++) {
        if(pixelWeight(pixels[i]) > pixelWeight(pixels[i + 1])) {
          changes ++;
          finished = false;
          color temp = pixels[i];
          pixels[i] = pixels[i + 1];
          pixels[i + 1] = temp;
        }
      }
      println("Changes: " + changes + " ,Finished: " + finished);
    }
    if(finished) {
      println("Done in " + (millis()/1000d) + "s");
    }
  }
  updatePixels();
}

public int pixelWeight(int pixel) {
  int weight = 0;
  //rule
  weight = (int)pixel;
  
  return weight;
}

public void keyPressed() {
  if(key == ' ') {
    saveFrame();
  }
}
