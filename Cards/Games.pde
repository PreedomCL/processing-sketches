class Card {
  PImage image;
  int value;
  int suit;
  public Card( int value, int suit) {
    this.value = value;
    this.suit = suit;
    
    if(suit == 1) {
      image = loadImage("card"+(value+1)+".png");
    }else if(suit == 2) {
      image = loadImage("card"+(value+14)+".png");
    }else if(suit == 3) {
      image = loadImage("card"+(value+27)+".png");
    }else if(suit == 4) {
      image = loadImage("card"+(value+40)+".png");
    }else {
      image = loadImage("card1.png");
    }
  }
  public void render(int x, int y) {
    image(image, x, y, 33*3, 45*3);
  }
}

abstract class CardGame {
  protected ArrayList<Card> deck = new ArrayList<Card>();
  protected String rules, name;
  public CardGame(String name, String rules) {
    this.name = name;
    this.rules = rules;
    
    for(int i = 1; i < 5; i++) {
      for(int j = 1; j < 14; j++) {
        deck.add(new Card(j, i));
      }
    }
  }
  
  public abstract void update();
  
  public void renderCards() {
    for(int i = 0; i < deck.size(); i++) {
      if(i < 26) {
        deck.get(i).render(i * 35, 10);
      }else {
        deck.get(i).render((i-26) * 35, 60);
      }
    }
  }
  
  protected void shuffle(int shuffles) {
    for(int j = 0; j < shuffles; j++) {
      for(int i = 0; i < deck.size(); i++) {
        int shift = (int)random(0, deck.size()-i);
        Card target = deck.get(i + shift);
        deck.set(i + shift, deck.get(i));
        deck.set(i, target);
        println(deck.get(i).value);
      }
    }
  }
}

class Streaks extends CardGame {
  
  int gameStage = 0;
  int score = 0;
  int highScore = 0;
  
  int cardX = 100;
  int currentCard = 0;
  
  boolean betLow;
  
  int timer = 0;
  Button higher = new Button(144, 48, loadImage("HigherButton1.png"), loadImage("HigherButton2.png"), loadImage("HigherButton3.png"), "Bet Higher");
  Button lower = new Button(144, 48, loadImage("LowerButton1.png"), loadImage("LowerButton2.png"), loadImage("LowerButton3.png"), "Bet Lower");
  Button start = new Button(144, 48, loadImage("StartButton1.png"), loadImage("StartButton2.png"), loadImage("StartButton3.png"), "Start Game");
  
  
  public Streaks() {
    super("Streaks", "Rules");
  }
  void update() {
    if(gameStage == 0) {
      image(loadImage("card1.png"), 100,400-45*3, 33*3, 45*3);
      start.update(328,500);
      if(start.activated) {
        shuffle(7);
        start.activated = false;
        gameStage = 1;
      }
    }else if(gameStage == 1) {
      image(loadImage("card1.png"), 100,400-45*3, 33*3, 45*3);
      lower.update(328-(cardX-100)/3, 500);
      higher.update(328+(cardX-100)/3,500);
      
      deck.get(currentCard).render(cardX, 400-45*3);
      cardX += 5;
      if(cardX > 351) {
        cardX = 100;
        gameStage = 2;
      }
    }else if(gameStage == 2) {
      image(loadImage("card1.png"), 100,400-45*3, 33*3, 45*3);
      lower.update(236, 500);
      higher.update(419,500);
      deck.get(currentCard).render(351, 400-45*3);
      
      if(lower.activated || higher.activated) {
        betLow = lower.activated;
        gameStage = 3;
      }
    }else if(gameStage == 3) {
      image(loadImage("card1.png"), 100,400-45*3, 33*3, 45*3);
      lower.update(236, 500);
      higher.update(419,500);
      
      deck.get(currentCard).render(351, 400-45*3);
      deck.get(currentCard+1).render(cardX, 400-45*3);
      
      if(cardX > 252) {
        timer ++;
        if(timer > 30) {
          if(cardX > 351) {
            timer = 0;
            gameStage = 4;
            cardX = 100;
          }else {
            cardX += 5;
          }
          
        }
      }else {
        cardX += 5;
      }
    }else if(gameStage == 4) {
      
      image(loadImage("card1.png"), 100,400-45*3, 33*3, 45*3);
      lower.update(236, 500);
      higher.update(419,500);
      
      deck.get(currentCard+1).render(351, 400-45*3);
      
      if(betLow) {
        if(deck.get(currentCard).value > deck.get(currentCard+1).value) {
          score++;
          if(score > highScore)
            highScore = score;
          currentCard++;
          gameStage = 2;
        }else {
          score = 0;
          gameStage = 0;
        }
      }else {
        if(deck.get(currentCard).value < deck.get(currentCard+1).value) {
          score++;
          if(score > highScore)
            highScore = score;
          currentCard++;
          gameStage = 2;
        }else {
          score = 0;
          gameStage = 0;
        }
      }
    }
    textSize(40);
    text("Streak: " + score, 10,40);
    textSize(20);
    text("High Score: " + highScore, 10,60);
  }
}

public class AceyDucey extends CardGame {
  
  public AceyDucey() {
    super("Acey Ducey", "Rules");
  }
  
  public void update() {
  
  }

}
