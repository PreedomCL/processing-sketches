
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
