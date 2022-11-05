
void setup() {
  size(600,600);
  frameRate(60);
  //surface.setResizable(true);
  loadPixels();
}

float size = 100;
int resolution = 1;
int pixel = 1;
long lastTime = 0;

void draw() {
  long startTime = System.currentTimeMillis();
  background(255);
  //draw every fourth pixel
  for(int x = pixel%resolution; x < width; x+= resolution) {
    for(int y = pixel/resolution; y < height; y+= resolution) {
      pixels[(x + y * width)] = processNoise(noise((x/size), (y/size), frameCount/100f));
    }
  }
  
  //scale
  //for(int x = 0; x < width/resolution; x++) {
  //  for(int y = 0; y < height/resolution; y++) {
  //    int c = processNoise(noise((x/size), (y/size), frameCount/100f));
  //    for(int h = 0; h < resolution; h++) {
  //      for(int k = 0; k < resolution; k++) {
  //        pixels[(x + y * width)*resolution + h + (k * width)] = c;
  //      }
  //    }
      
  //  }
  //}
  
  pixel ++;
  if(pixel > resolution * resolution) {
    pixel = 0;
  }
  updatePixels();
  long currentTime = System.currentTimeMillis();
  long frameTime = currentTime-lastTime;
  long executionTime = currentTime-startTime;
  text(frameTime, 0, 10);
  text(executionTime, 0, 20);
  text(frameTime - executionTime, 0, 30);
  text("FPS: " + 1000/frameTime, 0, 40);
  lastTime = currentTime;
}

int processNoise(float value) {
  float output = value;
  if((value) % 0.05 < 0.005) {
    return color(0);
  }
  float r = noise(value*100, frameCount/100f), g = noise(value*100, frameCount/100f), b = noise(value*100, frameCount/100f);
  return color(round(0.5f*r*r*r + 127), round(255*((g-1) * (g+1) * (g) + 0.5)), round(255 * ((b-1)*(b+1)*(b-1.5))));
  //return color(noise(value, frameCount/100f), noise(value*70, frameCount/100f)*255, noise(value*100, frameCount/100f)*255);
}
