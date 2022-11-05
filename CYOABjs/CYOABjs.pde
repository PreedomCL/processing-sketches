
Console console = new Console();
int keyDown = 0;

int pageIndex = 0;
Page[] pages = new Page[34];

public void setup() {
  size(500,700);
  //surface.setTitle("Chose Your Own Adventure");
  //surface.setResizable(true);
  textFont(loadFont("CourierNewPSMT-12.vlw"));
  
  console.allowInput = false;
  
  for(int i = 0; i < pages.length; i++) {
    pages[i] = new Page("/data/pages/page" + i + ".txt");
    pages[i].activate();
  }
  pages[0].activate();
}

public void draw() {
  background(0);
  console.update();
  pages[pageIndex].tick();
  EventManager.update();
}

public static class EventManager {
  
  private static ArrayList<Event> events = new ArrayList<Event>();
  
  public static void addEvent(Event e) {
    for(Event ee: events) {
      if(ee.name == e.name) {
        return;
      }
    }
    events.add(e);
  }
  
  public static void update() {
    for(Event e: events) {
      e.value = 0;
    }
  }
  
  public static int checkEvent(String name) {
    for(Event e: events) {
      if(e.name == name) {
        return e.value;
      }
    }
    println("  Error: No such event was found");
    return 0;
  }
  
  public static void triggerEvent(String name,int value) {
    for(Event e: events) {
      if(e.name == name) {
        e.value = value;
      }
    }
  }
}

public class Event {
  
  String name;
  int value;
  public Event(String name) {
    this.name = name;
  }
}

public void keyPressed() {
  keyDown = keyCode;
  //println(keyCode);
  //println(key);
}
