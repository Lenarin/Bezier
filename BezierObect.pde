class bezierObject {
  PVector[] points;
  int size;
  float pointRadius = 10;
  
  bezierObject() {
    points = new PVector[0];
    size = 0;
  }
  
  void addPoint(float x, float y) {
    points = (PVector[])append(points, new PVector(x, y)); 
    size++;
  }
  
  void print() {
    println("Current bezier array have this points: ");
    for (int i = 0; i < size; i++) {
      println(points[i].x + " " + points[i].y);  
    }
  }
  
  void drawPoints() {
    fill(0);
    noStroke();
    for (int i = 0; i < size; i++) {
      ellipse(points[i].x, points[i].y, pointRadius, pointRadius);  
    }
  }
  
  void drawLines() {
    fill(0);
    stroke(200);
    for (int i = 1; i < size; i++) {
      line(points[i-1].x, points[i-1].y, points[i].x, points[i].y);  
    }
  }
}
