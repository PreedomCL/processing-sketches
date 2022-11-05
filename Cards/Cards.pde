CardGame[] games = new CardGame[1];
int gameIndex = 0;
public void setup() {
  size(800,800);
  games[0] = new Streaks();
  games[gameIndex].shuffle(7);
  smooth(0);
}

public void draw() {
  background(13, 112, 58);
  games[gameIndex].update();
  
  //text(mouseX + ", " + mouseY, mouseX, mouseY);
}
