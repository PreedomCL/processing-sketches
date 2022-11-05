
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
public class Console {
  
  ArrayList<String> lines = new ArrayList<String>();
  ArrayList<Integer> lineColor = new ArrayList<Integer>();
  Boolean allowInput = true;
  String input = "";
  ArrayList<String> inputStream = new ArrayList<String>();
  
  ArrayList<String> toPrint = new ArrayList<String>();
  ArrayList<Integer> toPrintIndex = new ArrayList<Integer>();
  
  int cursorTimer = 60;
  boolean cursorOn = true;
  
  color printColor = color(255);
  
  public Console() {
    EventManager.addEvent(new Event("consoleInput"));
  }
  
  public void update() {
    for(int i = 0; i < lines.size(); i++) {
      fill(lineColor.get(i));
      text(lines.get(i), 10, i*15 + 20);
    }
    
    if(allowInput) {
      if(input == "") {
        input = ">";
      }
      if(keyDown >= 44 && keyDown <= 93 || keyDown == 222){
        input += key;
        keyDown = 0;
      }else if(keyDown == 8) {
        input = ">";
        keyDown = 0;
      }else if(keyDown == 32) {
        input += " ";
        keyDown = 0;
      }else if(keyDown == 10) {
        print(input, false);
        if(input == ">") {
          inputStream.add("");
        }else {
          inputStream.add(splitTokens(input, ">")[0]);
        }
        input = "";
        keyDown = 0;
        checkCommands();
        EventManager.triggerEvent("consoleInput", 1);
      }
    }
    fill(printColor);
    text(input, 10, lines.size() * 15 + 20);
    
    if(allowInput) {
      if(!cursorOn)
        fill(0);
      rect(input.length() * 7 + 10, lines.size() * 15 + 18, 7, 3);
      
      cursorTimer --;
      if(cursorTimer == 0) {
        cursorTimer = 60;
        cursorOn = !cursorOn;
      }
    }
    
    if(!toPrint.isEmpty()) {
      
    }
  }
  
  public void print(String input, boolean stylized) {
    if(stylized) {
      toPrint.add(input);
      toPrintIndex.add(lines.size());
      return;
    }
    lines.add(input);
    lineColor.add(printColor);
    if(lines.size() > height/15 - 1) {
      lines.remove(0);
      lineColor.remove(0);
    }
  }
  
  public void editLine(String edit, int index) {
    lines.set(index, edit);
  }
  
  public void clear(int operationIndex) {
    if(operationIndex == 0 || operationIndex == 2) {
      lines = new ArrayList<String>();
    }
    if(operationIndex == 1 || operationIndex == 2) {
      inputStream = new ArrayList<String>();
    }
    lineColor = new ArrayList<Integer>();
  }
  
  private void checkCommands() {
    if(inputStream.size() < 1)
      return;
    String[] commands = splitTokens(inputStream.get(inputStream.size()-1), " ");
    
    trim(commands);
    if(commands.length < 1)
      return;
    switch(commands[0]) {
      case "clr":
        if(commands.length < 2) {
          clear(0);
          break;
        }
        clear(parseInt(commands[1]));
        break;
      case "inpt":
        if(commands.length < 2) {
          printColor = color(255, 0, 0);
          print("Error: Parameters Not Met", false);
          printColor = color(255);
          break;
        }
        if(commands[1].equals("strm")) {
          
          print("Input Stream:", false);
          for(String s: inputStream) {
            print("  " + s, false);
          }
        }else if(commands[1].equals("off")) {
          printColor = color(255, 180, 40);
          print("allowInput = false", false);
          printColor = color(255);
          allowInput = false;
        }
        break;
      case "color":
        if(commands.length < 2) {
          printColor = color(255, 0, 0);
          print("Error: Parameters Not Met", false);
          printColor = color(255);
          break;
        }
        if(commands.length == 2) {
          printColor = color(parseInt(commands[1]));
        }else if(commands.length == 4) {
          printColor = color(parseInt(commands[1]), parseInt(commands[2]), parseInt(commands[3]));
        }
        break;
      case "print":
        if(commands.length < 2) {
          printColor = color(255, 0, 0);
          print("Error: Expected \'print >text to print<\'", false);
          printColor = color(255);
          break;
        }
        print(commands[1], false);
        break;
      case "jump":
        if(commands.length < 2) {
          printColor = color(255, 0, 0);
          print("Error: Expected \'jump >page#<\'", false);
          printColor = color(255);
          break;
        }
        pageIndex = parseInt(commands[1]);
        pages[pageIndex].activate();
        break;
      case "Hello":
        int rand = (int)random(0, 5);
        printColor = color(0, 255, 0);
        switch(rand){
          case 0:
            print(" Hello!", false);
            break;
          case 1:
            print(" Hi :)", false);
            break;
          case 2:
            print(" What do you want?", false);
            break;
          case 3:
            print(" Wassup", false);
            break;
          case 4:
            print(" Who are you?", false);
            break;
        }
        printColor = color(255);
    }
  }
}

public class Page {
  
  int id;
  int[] choiceIds = new int[2];
  String[] text;
  int[][] colorMap;
  
  public Page(String path) {
    BufferedReader reader = createReader(path);
    String input = "";
    Boolean linesLeft = true;
    
    while(linesLeft) {
      try {
        String line = reader.readLine();
        if(line == null) {
          linesLeft = false;
          continue;
        }
        input += line + "\n";
        
      } catch (IOException e) {
        e.printStackTrace();
        input = null;
      }
    }
    
    String[] data = splitTokens(input, "‼");
    printArray(data);
    id = parseInt(data[0]);
    text = splitTokens(data[1], "\n");
    String[] colorMapRaw = splitTokens(data[2], "\n");
    colorMap = new int[colorMapRaw.length][3];
    for(int i = 0; i < colorMapRaw.length; i++) {
      colorMap[i] = parseInt(splitTokens(colorMapRaw[i], " "));
    }
    choiceIds[0] = parseInt(trim(data[3]));
    choiceIds[1] = parseInt(trim(data[4]));
  }
  
  public void tick() {
    if(EventManager.checkEvent("consoleInput") != 0) {
      if(console.inputStream.get(console.inputStream.size()-1).equals("a")) {
        pageIndex = choiceIds[0];
        console.allowInput = false;
        pages[choiceIds[0]].activate();
      }else if(console.inputStream.get(console.inputStream.size()-1).equals("b")) {
        pageIndex = choiceIds[1];
        console.allowInput = false;
        pages[choiceIds[1]].activate();
      }
    }
  }
  
  public void activate() {
    console.clear(0);
    console.print("Page: " + id, false);
    for(int i = 0; i < text.length; i++) {
      console.printColor = color(colorMap[i][0], colorMap[i][1], colorMap[i][2]);
      console.print(text[i], false);
    }
    console.printColor = color(255);
    console.allowInput = true;
  }
}

