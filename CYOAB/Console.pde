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
      text(lines.get(i), 10, i*(fontSize + 3) + 20);
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
    text(input, 10, lines.size() * (fontSize + 3) + 20);
    
    if(allowInput) {
      if(!cursorOn)
        fill(0);
      rect(input.length() * 7 + 10, lines.size() * (fontSize + 3) + 18, 7, 3);
      
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
        break;
      case "ipconfig":
        print("Wireless LAN adapter Wi-Fi:", false);
        print("", false);
        print("IPv4: 69.420.666.10", false);
        break;
      case "font":
        if(commands.length != 2) {
          printColor = color(255, 0, 0);
          print("Error: Expected \'font >fontSize<\'", false);
          printColor = color(255);
          break;
        }
        
        fontSize = parseInt(commands[1]);
    }
  }
}
