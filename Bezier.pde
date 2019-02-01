bezierObject bezier;

void settings() {
  size(1280, 920);
}

void setup() {
  background(255);
  bezier = new bezierObject();
  bezier.addPoint(20, 100);
  bezier.addPoint(50, 200);
  bezier.addPoint(640, 460);
  bezier.print();
  bezier.drawLines();
  bezier.drawPoints();
}
