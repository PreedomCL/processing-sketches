
int scale = 100;
float layer = 0;

public void setup() {
  size(900,900);
  colorMode(HSB);
  loadPixels();
}

public void draw() {
  
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      float colorNoise = getNoise((float)x/scale, (float)y/scale, layer);
      colorNoise *= getNoise((float)x/(scale*2), (float)y/(scale*2), layer+1);
      
      float brightnessNoise = getNoise((float)x/(scale*5), (float)y/(scale*5), layer+1);
      color c = color(100 + (100*colorNoise), 255, 255*brightnessNoise);
      pixels[y*width+x] = c;
    }
  }
  
  updatePixels();
  
  layer += 0.05f;
}

public float getNoise(float x, float y, float layer) {
  float noiseOutput = 0;
  noiseOutput += noise(x, y, layer);
  return noiseOutput;
}
