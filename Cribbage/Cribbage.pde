
public int boardX, boardY;
public int boardScale = 15;
public Assets assets;
public int gameState = 0;

int playerToBeMoved = 0;
String spacesToBeMoved = "";

boolean gameOver = false;

Player players[];

public void setup() {
  size(1900,600);
  surface.setResizable(true);
  surface.setLocation(0,100);
  smooth(0);
  textAlign(CENTER, BOTTOM);
  
  assets = new Assets();
}

public void draw() {
  colorMode(HSB);
  background((frameCount%(255*20))/20,50,255);
  colorMode(RGB);
  boardX = (width/2)-(assets.board.width * 15)/2;
  boardY = (height/2)-(assets.board.height * 15)/2;
  image(assets.board, boardX, boardY, assets.board.width * boardScale, assets.board.height * boardScale);
  
  if(gameState == 0) {
    noStroke();
    fill(0, 200);
    rect(width/2 - 300, height/2 - 50, 600, 200);
    fill(255);
    textSize(28);
    text("How many Players?", width/2, height/2);
    textSize(18);
    text("Push a key (2-4) on the keyboard to select the number of players", width/2, height/2 + 20);
  }else if(gameState == 1) {
    for(Player p: players) {
      p.update();
    }
  }else if(gameState == 2) {
    for(Player p: players) {
      p.update();
    }
    noStroke();
    fill(0, 200);
    rect(width/2 - 300, height/2 - 50, 600, 100);
    fill(255);
    text("Player " + (playerToBeMoved + 1) + " moving " + spacesToBeMoved + " spaces", width/2, height/2);
  }
}

public class Assets {
  public PImage board;
  
  public Assets() {
    board = loadImage("cribbageBoard.png");
  }
}


void keyPressed() {
  if(gameState == 0) {
    if(key == '2') {
      players = new Player[2];
      players[0] = new Player(2, color(255,0,0), 0);
      players[1] = new Player(3, color(75,75,200), 1);
      gameState = 1;
    }else if (key == '3') {
      players = new Player[3];
      players[0] = new Player(1, color(255,0,0), 0);
      players[1] = new Player(2, color(75,75,200), 1);
      players[2] = new Player(3, color(75,200,75), 2);
      gameState = 1;
    }else if (key == '4') {
      players = new Player[4];
      players[0] = new Player(1, color(255,0,0), 0);
      players[1] = new Player(2, color(75,75,200), 1);
      players[2] = new Player(3, color(75,200,75), 2);
      players[3] = new Player(4, color(200,200,75), 3);
      gameState = 1;
    }
  }else if(gameState == 1) {
    if(key == '1') {
      playerToBeMoved = 0;
      gameState = 2;
    }else if(key == '2') {
      playerToBeMoved = 1;
      gameState = 2;
    }else if (key == '3') {
      playerToBeMoved = 2;
      gameState = 2;
    }else if (key == '4') {
      playerToBeMoved = 3;
      gameState = 2;
    }
  }else if(gameState == 2) {
    if(key == '0' || key == '1' || key == '2' ||key == '3' ||key == '4' ||key == '5' ||key == '6' ||key == '7' ||key == '8' ||key == '9') {
      spacesToBeMoved += key;
    }
    if(keyCode == ENTER) {
      if(spacesToBeMoved == "" || spacesToBeMoved == "0") {
        return;
      }
      players[playerToBeMoved].move(parseInt(spacesToBeMoved));
      gameState = 1;
      spacesToBeMoved = "";
    }
    if(keyCode == BACKSPACE) {
      spacesToBeMoved = "";
    }
  }
}
