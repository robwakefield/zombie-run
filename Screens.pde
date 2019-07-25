// allows each screen that is visible to the user to be built and displayed
class Screen {
  Screen() {
  }
  void clearArrays() {
    buttons.clear();
    texts.clear();
    graphs.clear();
  }
  void showMain() {
    clearArrays();
    texts.add(new Text(width/2, height/3 - 50, "Zombie Run"));
    texts.add(new Text(10, height - 30, "User: "+currentUser, 24));
    buttons.add(new Button(width/2, height/2 - 50, width * 0.75, 50, "Click to Play"));
    buttons.add(new Button(width/2, height/2 + 25, width * 0.75, 50, "How to Play"));
    buttons.add(new Button(width/2, height/2 + 100, width * 0.75, 50, "Leaderboard"));
    buttons.add(new Button(width - 100, height - 40, 180, 50, "Settings"));
  }
  void showHelp(boolean info) {
    clearArrays();
    texts.add(new Text(270, 50, "How To Play", 75));
    buttons.add(new Button(125, 130, 200, 50, "Main Menu"));
    buttons.add(new Button(340, 130, 200, 50, "Controls"));
    buttons.add(new Button(555, 130, 200, 50, "Algorithms"));
    if (info) {
      buttons.get(1).selected = true;
      texts.add(new Text(30, 200, "Move        Mousepad\nPause       P\n\nDodge the zombies and\ncollect upgrades to level\nup (change this)", 50));
    } else {
      buttons.get(2).selected = true;
      texts.add(new Text(40, 175, "JAVA:\n// Movement algorithm for zombies\nfor(int i = 0, i < 24; i ++):\n  if(c in elephant){\n  }\n}", 14));
      texts.add(new Text(375, 175, "PSEUDOCODE:\n# Movement algorithm for zombies\nfor i from 1 to 24:\n  if c in elephant", 14));
    }
  }
  void showLeaderboard(boolean progress) {
    clearArrays();
    texts.add(new Text(275, 50, "LeaderBoard", 75));
    buttons.add(new Button(125, 130, 200, 50, "Main Menu"));
    buttons.add(new Button(340, 130, 200, 50, "Progress"));
    buttons.add(new Button(555, 130, 200, 50, "Rankings"));
    if (progress) {
      buttons.get(1).selected = true;
      Graph plotter = new Graph(75, height - 75, 300, 600);
      plotter.xName = "Time";
      plotter.yName = "Score";
      // get user data
      String[] data = loadStrings("files/users/"+currentUser+".txt")[0].split(",");
      int[] points = new int[data.length];
      for (int i = 0; i < data.length; i++) {
        points[i] = int(data[i]);
      }
      plotter.plot(points);
      // plot to graph
      graphs.add(plotter);
    } else {
      buttons.get(2).selected = true;
      // get user data
      String[] ranks = loadStrings("files/ranks.txt");
      for (int i = 0; i < ranks.length; i++) {
        String[] data = ranks[i].split(",");
        buttons.add(new Button(175, 225 + i * 75, 300, 50, data[0]));
        buttons.add(new Button(525, 225 + i * 75, 300, 50, data[1]+"pts"));
        // makes sure that a max of 5 users are shown
        if (i >= 4) {
          break;
        }
      }
    }
    //buttons.add(new Button(width/2, height * 0.6, width * 0.8, height * 0.6, "Graph"));
  }
  void showSettings() {
    clearArrays();
    texts.add(new Text(200, 50, "Settings", 75));
    buttons.add(new Button(125, 130, 200, 50, "Main Menu"));
    buttons.add(new Button(175, 225, 300, 50, "Change User"));
    buttons.add(new Button(525, 225, 300, 50, currentUser));
    buttons.add(new Button(175, 300, 300, 50, "Sound"));
    if (sound) {
      buttons.add(new Button(525, 300, 300, 50, "ON"));
    } else {
      Button b = new Button(525, 300, 300, 50, "OFF");
      buttons.add(b);
      b.selected = true;
    }
    buttons.add(new Button(175, 375, 300, 50, "Music"));
    if (music) {
      buttons.add(new Button(525, 375, 300, 50, "ON"));
    } else {
      Button b = new Button(525, 375, 300, 50, "OFF");
      buttons.add(b);
      b.selected = true;
    }
  }
  void showGame() {
    clearArrays();    
    texts.add(new Text(width - 350, 15, "Coins: " + player.coins, 22));
    texts.add(new Text(width - 200, 15, "Health: " + player.health, 22));
    texts.add(new Text(width - 188, 40, "Speed: " + player.speed, 22));
    buttons.add(new Button(70, 25, 110, 30, "Pause"));
    texts.add(new Text(160, 10, "12345 pts", 40));
  }
  void showPause() {
    clearArrays();
    texts.add(new Text(width/2, height/3, "432 pts"));
    buttons.add(new Button(185, 30, 360, 40, "Main Menu"));
    //buttons.add(new Button(105, 25, 200, 30, "Main Menu"));
    buttons.add(new Button(width/2, height/2, 350, 50, "Resume"));
    buttons.add(new Button(width/2, height/2 + 75, 350, 50, "Upgrade " + player.upgradeCost()));
    Button sound_btn = new Button(width/2 - 90, height/2 + 150, 170, 50, "Sound");
    if (!sound) {
      sound_btn.selected = true;
    }
    Button music_btn = new Button(width/2 + 90, height/2 + 150, 170, 50, "Music");
    if (!music) {
      music_btn.selected = true;
    }
    buttons.add(sound_btn);
    buttons.add(music_btn);

    buttons.add(new Button(width - 220, 40, 400, 60, "Coins: "+player.coins+"    Health: "+player.health+"\n                  Speed: "+player.speed, 22));
    //buttons.add(new Button(width - 210, 40, 320, 60, "Coins: "+player.coins+"    Health: "+player.health+"\n                  Speed: "+player.speed, 22));
  }
}
