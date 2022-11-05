
Agent[] agents = new Agent[100000];

public void setup() {
  //size(1500,900);
  size(500,500);
  background(0);
  loadPixels();
  
  for(int i = 0; i < agents.length; i++) {
    float angle = random(TWO_PI);
    float radius = random(10f);
    agents[i] = new Agent((int)(cos(angle) * radius) + width/2, (int)(sin(angle) * radius) + height/2, new PVector((cos(angle) * radius), (sin(angle) * radius)));
    agents[i].update();
  }
  
  //agents[0] = new Agent(200,0,new PVector(0,1));
  //agents[1] = new Agent(220,0,new PVector(-1,1));
  
}

float decay = 10;

public void draw() {
  
  for(int p = 0; p < pixels.length; p++) {
    if(red(pixels[p]) > 0) {
      pixels[p] = color(red(pixels[p])-decay, green(pixels[p])-decay, blue(pixels[p])-decay);
      //pixels[p] = color(red(pixels[p])-((256-red(pixels[p]))*decay), green(pixels[p])-((256-green(pixels[p]))*decay), blue(pixels[p])-((256-blue(pixels[p])) * decay));
    }
  }
  for(Agent a: agents) {
    a.update();
  }
  updatePixels();
  
  if(frameCount == 100) {
    saveFrame();
  }
  
}
