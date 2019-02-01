PVector point;
bezierObject bezier;
Slider slider = new Slider(1180, 50, 80);

void drawGUI() {
  //Reset button
  rectMode(CORNER);
  stroke(0);
  if (mouseX >= 1180 && mouseX <= 1260 && mouseY >= 0 && mouseY <= 25) {
    fill(200);  
  } else {
    fill(255);
  }
  rect(1180, 0, 80, 25);
  
  //Slider
  slider.updateSlider(mouseX, mouseY);
  slider.drawSlider();
  
  //Text
  fill(0);
  text("Clear", 1207, 17);
  text("RMB to create new point", 10, 10);
  text("LMB to drag points", 10, 22);
  text("Change t", 1197, 40);
}

void settings() {
  size(1280, 920);
}

void setup() {
  background(255);
  drawGUI();
  bezier = new bezierObject();
  point = new PVector(-1, -1);
}

void draw() {
  background(255);
  drawGUI();
  bezier.drawLines();
  bezier.drawPoints();
  if (bezier.size >= 2) {
    bezier.setT(slider.value);
    bezier.drawBezier();
  }
}

void mouseReleased() {
  if (mouseButton == RIGHT) {
    bezier.addPoint(mouseX, mouseY);
    bezier.calcBezierPoints();
  }
  if (mouseButton == LEFT && mouseX >= 1180 && mouseX <= 1260 && mouseY >= 0 && mouseY <= 25) {
    bezier.clear();
    slider.setValue(1);
  }
  if (point.x != -1) {
    point = new PVector(-1, -1);
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    point = bezier.getPoint(mouseX, mouseY); 
  }
}

void mouseDragged() {
  if (point.x != -1) {
    bezier.calcBezierPoints();
    point.x = mouseX;
    point.y = mouseY;
  } 
}
