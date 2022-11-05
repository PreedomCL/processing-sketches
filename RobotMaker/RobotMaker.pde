ArrayList<Square> squares = new ArrayList<Square>();
Square currentSquare;

void setup() {
  colorMode(HSB, 100, 100, 100);
  size(800,800);
  squares.add(new Square(0,0,100,100, color(0)));
  currentSquare = squares.get(0);
}

boolean mouseDown = false;
boolean firstClick = true;
boolean zDown = false;
boolean sDown = false;
boolean oDown = false;
color selectedColor = color(100,100,100);
int selectedWidth = 100, selectedHeight = 100, currentIndex = 0;
void draw() {
  background(0,0,100);
  for(int i = 0; i < squares.size(); i++) {
    squares.get(i).render();
  };

  //width and height
  if(keyPressed) {
    if(key == '=' && selectedWidth < 800) {
      selectedWidth ++;
    }else if(key == '-' && selectedHeight < 800) {
      selectedHeight ++;
    }else if(key == ']' && selectedWidth > 10) {
      selectedWidth --;
    }else if(key == '[' && selectedHeight > 10) {
      selectedHeight --;
    }else if(key == '1' && hue(selectedColor) <= 100) {
      selectedColor = color(hue(selectedColor)+0.25, saturation(selectedColor), brightness(selectedColor));
    }else if(key == '2' && saturation(selectedColor) <= 100) {
      selectedColor = color(hue(selectedColor), saturation(selectedColor)+1, brightness(selectedColor));
    }else if(key == 'w' && saturation(selectedColor) >= 0) {
      selectedColor = color(hue(selectedColor), saturation(selectedColor)-1, brightness(selectedColor));
    }else if(key == '3' && brightness(selectedColor) <= 100) {
      selectedColor = color(hue(selectedColor), saturation(selectedColor), brightness(selectedColor)+1);
    }else if(key == 'e' && brightness(selectedColor) >= 0) {
      selectedColor = color(hue(selectedColor), saturation(selectedColor), brightness(selectedColor)-1);
    }else if(key == 'z' && !zDown) { //<>//
      zDown = true;
      currentSquare = squares.get(currentIndex - 1);
      squares.remove(currentIndex);
      currentIndex --;
    }else if(key != 'z' && zDown) {
      zDown = false;
    }else if(key == 's' && !sDown) {
      sDown = true;
      exportDrawing();
    }else if(key != 's' && sDown) {
      sDown = false;
    }else if(key == 'o' && !oDown) {
      oDown = true;
      loadDrawing();
    }else if(key != 'o' && oDown) {
      oDown = false;
    }
    key = '~';
  }
  currentSquare.w = selectedWidth;
  currentSquare.h = selectedHeight;
  currentSquare.x = mouseX - (currentSquare.w/2);
  currentSquare.y = mouseY - (currentSquare.h/2);
  currentSquare.c = selectedColor;
  currentSquare.outline = color(100,100,100);
  
  if(mousePressed && !mouseDown) {
    if(firstClick) {
      firstClick = false;
    }else {
      currentSquare.outline = color(0);
      currentSquare = new Square(mouseX,mouseY,100,100, selectedColor);
      squares.add(currentSquare);
      currentIndex ++;
    }
    mouseDown = true;
  }else if(!mousePressed && mouseDown){
    mouseDown = false;
  }
}

void exportDrawing() {
  PrintWriter output =  createWriter("imageData" + hour() + minute() + second() + ".txt");
  String outputString = new String();
  
  for(int i = 0; i < squares.size() - 1; i ++) {
    Square s = squares.get(i);
    outputString += s.x + ",";
    outputString += s.y + ",";
    outputString += s.w + ",";
    outputString += s.h + ",";
    outputString += hue(s.c) + ",";
    outputString += saturation(s.c) + ",";
    outputString += brightness(s.c);
    outputString += ";";
  };
  
  output.println(outputString);
  output.flush();
  output.close();
  println("Picture Data:");
  println(outputString);
}

void loadDrawing() {
  BufferedReader reader = createReader("imageDataLoad.txt");
  String inputData; 
  try {
    inputData = reader.readLine();
  } catch (IOException e) {
    e.printStackTrace();
    inputData = null;
  }
  
  if(inputData != null) {
    squares = new ArrayList<Square>();
    String[] loadedSquares = split(inputData, ";");
    for(int i = 0; i < loadedSquares.length-1; i ++) {
     String[] feilds = split(loadedSquares[i], ",");
     squares.add(new Square(parseInt(feilds[0]), parseInt(feilds[1]), parseInt(feilds[2]), parseInt(feilds[3]), color(parseInt(feilds[4]),parseInt(feilds[5]),parseInt(feilds[6]))));
    }
    currentSquare = new Square(mouseX,mouseY,100,100, selectedColor);
    squares.add(currentSquare);
    currentIndex ++;
  }
}

class Square {
  int x,y,w,h;
  color c, outline;
  Square(int x,int y,int w,int h,color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
    this.outline = color(0);
  }
  
  void render() {
    fill(c);
    stroke(outline);
    rect(x, y, w, h);
  }
}
