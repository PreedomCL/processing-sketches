public class GamePiece {
  
  private int lane, targetPosition;
  public float x = 0, y = 0, w = boardScale, h = boardScale;
  private color displayColor;
  
  public int position;
  
  public GamePiece(int lane, int startingPosition, color displayColor) {
    this.lane = lane;
    this.displayColor = displayColor;
    
    this.position = startingPosition;
    targetPosition = (int)position;
  }
  
  public void update() {
    
    if((int)position != targetPosition) {
      position += 1;
    }
    
   
    
    int boardW = assets.board.width * boardScale, boardH = assets.board.height * boardScale;
    if(position < 1) {
      x = boardX + boardW - ((boardScale * 5) + (position * boardScale * 2));
      y = boardY + boardH - (boardScale * (lane*2));
    }else if(position < 41) {
      x = boardX + boardW - ((boardScale * 10) + (position * boardScale * 2) + (floor((position-1)/5) * boardScale * 2));
      y = boardY + boardH - (boardScale * (lane*2));
    }else if(position < 46) {
      x = boardX + (boardScale * (lane * 2 - 1));
      y = boardY + boardH - ((boardScale * 10) + (boardScale * (position-40) * 2));
    }else if(position < 86) {
      x = boardX + ((boardScale * 9) + ((position-45) * boardScale * 2) + (floor((position-46)/5) * boardScale * 2));
      y = boardY + (boardScale * (lane * 2 - 1));
    }else if(position < 121) {
      x = boardX + boardW - ((boardScale * 10) + ((position-85) * boardScale * 2) + (floor((position-86)/5) * boardScale * 2));
      y = boardY + boardH - ((boardScale * 11) + (boardScale * (lane*2)));
    }else {
      x = boardX + boardScale * 17;
      y = boardY + boardScale * 15;
    }
    
    noStroke();
    fill(displayColor);
    rect(x, y, w, h);
    fill(red(displayColor) - 50, green(displayColor) - 50, blue(displayColor) - 50);
    rect(x+2, y+2, w-4, h-4);
  }
  
  public void move(int destination) {
    if(targetPosition == position) {
      targetPosition = destination;
      return;
    }
    
    println("Piece is already in motion!");
  }
}

public class Player {
  
  private GamePiece peg1, peg2;
  private int frontPeg = 1, playerColor;
  public int score = 0, id;
  
  public Player(int lane, color playerColor, int id) {
    peg1 = new GamePiece(lane, 0, playerColor);
    peg2 = new GamePiece(lane, -1, playerColor);
    this.id = id;
    this.playerColor = playerColor;
  }
  
  public void move(int spaces) {
    if(frontPeg == 1) {
      score = peg1.position + spaces;
      peg2.move(score);
      frontPeg = 2;
    }else {
      score = peg2.position + spaces;
      peg1.move(score);
      frontPeg = 1;
    }
  }
  
  public void update() {
    peg1.update();
    peg2.update();
    
    pushStyle();
      textAlign(LEFT,TOP);
      textSize(20);
      fill(playerColor);
      int legendX = boardX + 60 * id, legendY = boardY + (assets.board.height * boardScale) + 10 + 23 * id;
      String legendText = "" + (id+1);
      rect(legendX, legendY, 120, 23);
      fill(255);
      text(legendText, legendX + 5, legendY);
    popStyle();
  }
  
}
