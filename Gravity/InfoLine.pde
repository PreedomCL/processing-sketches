
class InfoLine {
  PVector p1 = new PVector(), p2 = new PVector();
  int c;
  InfoLine(PVector p1, PVector p2, color c) {
    this.p1 = p1;
    this.p2 = p2;
    this.c = c;
  }
  
  InfoLine(float x1, float y1, float x2, float y2, int c) {
    this.p1.x = x1;
    this.p1.y = y1;
    this.p2.x = x2;
    this.p2.y = y2;
    this.c = c;
  }
  
  void render() {
    stroke(c);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}
