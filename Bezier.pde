bezierObject bezier;

void drawGUI() {
  //Reset button
  stroke(0);
  if (mouseX >= 1180 && mouseX <= 1260 && mouseY >= 0 && mouseY <= 25) {
    fill(200);  
  } else {
    fill(255);
  }
  rect(1180, 0, 80, 25);
  fill(0);
  text("Clear", 1207, 17);
}

void settings() {
  size(1280, 920);
}

void setup() {
  background(255);
  drawGUI();
  bezier = new bezierObject();
}

void draw() {
  background(255);
  drawGUI();
  bezier.drawLines();
  bezier.drawPoints();
  if (bezier.size >= 2) {
    
    bezier.drawBezier();
  }
}

void mouseClicked() {
  if (mouseButton == RIGHT) {
    bezier.addPoint(mouseX, mouseY);
    bezier.calcBezierPoints();
  }
  if (mouseButton == LEFT && mouseX >= 1180 && mouseX <= 1260 && mouseY >= 0 && mouseY <= 25) {
    bezier.clear();  
  }
}
