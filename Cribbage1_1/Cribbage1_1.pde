
public int boardX, boardY;
public int boardScale = 15;
public Assets assets;
public int gameState = 0;

boolean keyJustPressed = false;

int playerToBeMoved = 0;
String spacesToBeMoved = "";

boolean gameOver = false;

TextFeild playerCount = new TextFeild(650, 200, 600, 150, "Press a key (2-4) to set the number of players"), playerNames[];

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
  
  if(players == null) {
    playerCount.update();
    if(playerCount.textSubmitted) {
      if(playerCount.getInputText().equals("2")) {
        players = new Player[2];
        players[0] = new Player(2, color(255,0,0), 0);
        players[1] = new Player(3, color(75,75,200), 1);
      }else if (playerCount.getInputText().equals("3")) {
        players = new Player[3];
        players[0] = new Player(1, color(255,0,0), 0);
        players[1] = new Player(2, color(75,75,200), 1);
        players[2] = new Player(3, color(75,200,75), 2);
      }else if (playerCount.getInputText().equals("4")) {
        players = new Player[4];
        players[0] = new Player(1, color(255,0,0), 0);
        players[1] = new Player(2, color(75,75,200), 1);
        players[2] = new Player(3, color(75,200,75), 2);
        players[3] = new Player(4, color(200,200,75), 3);
      }else {
        playerCount.textSubmitted = false;
      }
      
    }else {
      playerCount.setVisible(true);
      playerCount.setActive(true);
    }
  }else if(players[players.length-1].getName() == "") {
    for(Player p: players) {
      p.update();
    }
    if(playerNames == null) {
      playerNames = new TextFeild[players.length];
      for(int i = 0; i < players.length; i ++) {
        playerNames[i] = new TextFeild(width/2 - 200, height/4, 400, 200, "Input player " + i + "'s name");
      }
    }else {
      boolean updated = false;
      for(int i = 0; i < playerNames.length; i ++) {
        if(!playerNames[i].textSubmitted && !updated) {
          updated = true;
          playerNames[i].setActive(true);
          playerNames[i].setVisible(true);
        }else if(playerNames[i].textSubmitted && !updated && players[i].getName() != "") {
          players[i].setName(playerNames[i].inputText);
        }
      }
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
  
  keyJustPressed = false;
}

public class Assets {
  public PImage board;
  
  public Assets() {
    board = loadImage("cribbageBoard.png");
  }
}


void keyPressed() {
  keyJustPressed = true;
  
}
