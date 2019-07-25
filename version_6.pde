////
//
// Version 1: Basic Main Menu interface
// Version 2: Help screen and further menu enhancements
// Version 3: Added graph and leaderboard to leaderboard screen
// Version 4: Added data for leaderboard and ability to plot progress graph from a file
// Version 5: Added start of gameplay and pause screen features
// Version 6: Start gameplay ????? protect the brain in middke!
//
////


ArrayList<Button> buttons = new ArrayList<Button>();
ArrayList<Text> texts = new ArrayList<Text>();
ArrayList<Graph> graphs = new ArrayList<Graph>();

Screen Screen = new Screen();

boolean sound = true;
boolean music = false;

boolean menus = true;
boolean paused = false;

String currentUser = "robwakefield";

Player player;

void setup() {
  // set window size
  size(800, 600);
  // set main game font
  textFont(createFont("Games.ttf", 18));
  // start with main menu screen
  Screen.showMain();
}

void mousePressed() {
  // checks for a button press
  // calls correct function based on which button has been pressed
  for (int b = 0; b < buttons.size(); b++) {
    if (buttons.get(b).clicked(mouseX, mouseY)) {
      String test = buttons.get(b).text;
      // regex expression to remove all digits from string
      // then removes whitespace at end of string
      test = test.replaceAll("\\d", "").trim();
      switch(test) {
      case "Click to Play":
        startGame();
        Screen.showGame();
        menus = false;
        paused = false;
        break;
      case "How to Play":
        Screen.showHelp(true);
        break;
      case "Leaderboard":
        Screen.showLeaderboard(true);
        break;
      case "Settings":
        Screen.showSettings();
        break;
      case "Main Menu":
        menus = true;
        paused = false;
        Screen.showMain();
        break;
      case "Controls":
        Screen.showHelp(true);
        break;
      case "Algorithms":
        Screen.showHelp(false);
        break;
      case "Progress":
        Screen.showLeaderboard(true);
        break;
      case "Rankings":
        Screen.showLeaderboard(false);
        break;
      case "Change User":
        // create user / switch
        break;
      case "Sound":
        sound = !sound;
        if (menus) {
          Screen.showSettings();
        } else {
          Screen.showPause();
        }
        break;
      case "Music":
        music = !music;
        if (menus) {
          Screen.showSettings();
        } else {
          Screen.showPause();
        }
        break;
      case "Pause":
        pauseGame();
        break;
      case "Resume":
        paused = false;
        Screen.showGame();
        break;       
      case "Upgrade":
        player.health -= 2;
        player.speed += 3;
        player.coins -= 50;
        Screen.showPause();
        break;
      }
    }
  }
}

void keyPressed() {
  if (!menus) {
    if (key == 'p' || key == 'P') {
      if (!paused) {
        pauseGame();
      } else {
        paused = false;
        Screen.showGame();
      }
    }
  }
}

void startGame() {
  player = new Player(width/2, height/2);
}

void pauseGame() {
  fill(0, 50);
  noStroke();
  rectMode(CORNER);
  rect(0, 0, width, height);
  paused = true;
  Screen.showPause();
}

void draw() {
  if (!paused && !menus) {
    background(20, 250, 130);
    noStroke();
    fill(150, 130, 10);
    ellipse(width/2, height/2, 100, 100);
    player.moveTo(mouseX, mouseY);
    player.show();
  } else if (menus) {
    background(255);
  } else {
    //background(20, 250, 130);
  }
  // displays all gui elements on screen
  for (Button b : buttons) {
    b.show();
  }
  for (Text t : texts) {
    t.show();
  }
  for (Graph g : graphs) {
    g.show();
  }
}
