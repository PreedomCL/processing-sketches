class Button {
  int x, y, w, h;
  PImage texture, textureOnHover, textureOnPressed;
  String tooltip;
  boolean hovering, pressed, activated;
  public Button(int w, int h, PImage texture, PImage textureOnHover, PImage textureOnPressed, String tooltip) {
    this.w = w;
    this.h = h;
    this.texture = texture;
    this.textureOnHover = textureOnHover;
    this.textureOnPressed = textureOnPressed;
    this.tooltip = tooltip;
  }
  
  public void update(int x, int y) {
    hovering = mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
    
    if(hovering) {
      if(mousePressed) {
        if(activated) {
          activated = false;
        }
        if(!pressed) {
          activated = true;
        }
        pressed = true;
        image(textureOnPressed, x, y, w, h);
      }else {
        image(textureOnHover, x, y, w, h);
        pressed = false;
      }
    }else {
      image(texture, x, y, w, h);
    }
  }
}
