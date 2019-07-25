// UI elements that allow the user to interact with the program
// Simple text lebel
class Text {
  PVector pos;
  String text;
  float textSize;
  Text(float x, float y, String text) {
    pos = new PVector(x, y);
    this.text = text;
    textSize = 100;
  }
  Text(float x, float y, String text, float txtsize) {
    pos = new PVector(x, y);
    this.text = text;
    textSize = txtsize;
  }
  void show() {
    textSize(textSize);
    fill(0);
    if (textSize > 50) {
      textAlign(CENTER, CENTER);
      text(text, pos.x, pos.y);
    } else {
      textAlign(LEFT, TOP);
      if (textSize <= 20) {
        textFont(createFont("Serif", textSize));
        rectMode(CORNER);
        fill(255);
        stroke(0);
        strokeWeight(1);
        rect(pos.x - 10, pos.y - 5, 300, 400, 5);
      }
      fill(0);
      text(text, pos.x, pos.y);
      textFont(createFont("Games.ttf", 18));
    }
  }
}
// Clickable button
class Button {
  String text;
  PVector pos;
  PVector size;
  float textSize;
  boolean selected = false;
  Button(float x, float y, float w, float h, String text) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    this.text = text;
    textSize = 32;
  }
  Button(float x, float y, float w, float h, String text, float textsize) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
    this.text = text;
    textSize = textsize;
  }
  void show() {
    rectMode(CENTER);
    stroke(0);
    strokeWeight(1);
    if (selected) {
      fill(200);
    } else {
      fill(240);
    }
    rect(pos.x, pos.y, size.x, size.y, (size.x * size.y) / 600);
    textAlign(CENTER, CENTER);
    textSize(textSize);
    fill(0);
    text(text, pos.x, pos.y);
  }
  // Checks to see if button has been clicked
  boolean clicked(float x_, float y_) {
    if (x_ > pos.x - size.x / 2 && x_ < pos.x + size.x / 2) {
      if (y_ > pos.y - size.y / 2 && y_ < pos.y + size.y / 2) {
        return true;
      }
    }
    return false;
  }
  void onClick() {
  }
}
// 2 axis graph used to plot data ######################## score saved after each game and top x scores in order saved to file.
class Graph {
  PVector pos;
  PVector size;
  String xName, yName;
  ArrayList<PVector> points = new ArrayList<PVector>();
  Graph(float x, float y, float h, float w) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
  }
  void show() {
    stroke(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(xName, pos.x + 0.5 * size.x, pos.y + 40);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(HALF_PI);
    translate(-pos.x, -pos.y);
    text(yName, pos.x - 0.5 * size.y, pos.y + 40);
    popMatrix();
    // now draw data points at equal spacing
    stroke(150);
    fill(240);
    strokeWeight(2);
    beginShape();
    PVector p0 = points.get(0);
    vertex(p0.x, pos.y);
    vertex(p0.x, p0.y);
    for (int i = 0; i < points.size() - 1; i++) {
      PVector p1 = points.get(i);
      PVector p2 = points.get(i + 1);
      line(p1.x, p1.y, p2.x, p2.y);
      vertex(p2.x, p2.y);
    }
    PVector pl = points.get(points.size() - 1);
    vertex(pl.x, pos.y);
    endShape();
    stroke(0);
    strokeWeight(8);
    for (int i = 1; i < points.size(); i++) {
      point(points.get(i).x, points.get(i).y);
    }
    // now draw axis
    stroke(0);
    strokeWeight(2);
    line(pos.x, pos.y, pos.x + size.x, pos.y);
    line(pos.x, pos.y, pos.x, pos.y - size.y);
  }
  void plot(int[] data) {
    points.clear();
    float x_spacing = size.x / data.length;
    // find min and max points
    int min = 100000;
    int max = 0;
    for (int i = 0; i < data.length; i++) {
      if (data[i] < min) {
        min = data[i];
      }
      if (data[i] > max) {
        max = data[i];
      }
    }
    int range = max - min;
    float y_scale = (size.y / range) * 0.8;
    for (int i = 0; i < data.length; i++) {
      float x = pos.x + x_spacing * i;
      float y = pos.y - ((size.y / 10)) - data[i] * y_scale;
      points.add(new PVector(x, y));
    }
  }
}






/////


///


//

class popUp {
  String title;
  String message;
  PVector pos;
  PVector[] points = new PVector[4];
  popUp(String title, String message, float x, float y) {
    this.title = title;
    this.message = message;
    pos = new PVector(x, y);
    generateVertices(x, y);
  }
  void show() {
    stroke(255, 0, 0);
    strokeWeight(2);
    line(points[0].x, points[0].y, points[1].x, points[1].y);
    line(points[1].x, points[1].y, points[2].x, points[2].y);
    line(points[2].x, points[2].y, points[3].x, points[3].y);
    line(points[3].x, points[3].y, points[0].x, points[0].y);
  }
  void generateVertices(float x, float y) {
    int lineLength = 30;
    float lineHeight = 20;
    float pointerOffset = 20;
    int rows = message.length() / lineLength;
    if (message.length() % lineLength > 0) {
      rows += 1;
    }
    float h = lineHeight * rows;
    y -= pointerOffset;
    if (rows <= 1) {
      float w = message.length() * 3;
      points[0] = new PVector(x - w, y - h);
      points[1] = new PVector(x + w, y - h);
      points[2] = new PVector(x + w, y);
      points[3] = new PVector(x - w, y);
    } else {
      points[0] = new PVector(x - 40, y - h);
      points[1] = new PVector(x + 40, y - h);
      points[2] = new PVector(x + 40, y);
      points[3] = new PVector(x - 40, y);
    }
  }
}
