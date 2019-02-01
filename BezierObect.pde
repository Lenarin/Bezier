class bezierObject {
  PVector[] points;
  PVector[] bezierPoints;
  PVector[] supportDots;
  bezierObject supportBezier;
  int size;
  float pointRadius = 10;
  int maxT = 100;
  int currentT = maxT;
  
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
  
  float fact(float n) {
    float result = 1;
    
    for (int i = 1; i <= n; i++) {
      result *= i;  
    }
    
    return result;
  }
  
  float calcCombine(float n, float k) {
    float result;
    
    result = fact(n) / (fact(k) * fact(n - k));
    
    return result;
  }
  
  void clear() {
    points = new PVector[0];
    bezierPoints = new PVector[0];
    size = 0;
    supportDots = new PVector[0];
  }
  
  PVector calcBezier(float t) {
    PVector result = new PVector(0, 0);
    for (int i = 0; i < size; i++) {
      float mult = ( calcCombine(size - 1, i) * pow(t, i) * pow((1 - t), (size - 1 - i)) ); 
      result.x += points[i].x * mult;
      result.y += points[i].y * mult;
    }
    
    return result;
  }
  
  void calcBezierPoints() {
    bezierPoints = new PVector[0];
    for (float t = 0; t <= 1; t += 0.01) {
      PVector pointCoord = calcBezier(t);
      bezierPoints = (PVector[])append(bezierPoints, pointCoord);
    }
  }
  
  void drawBezier() {
    fill(0);
    stroke(0);
    for (int i = 1; i <= currentT; i++) {
      line(bezierPoints[i-1].x, bezierPoints[i-1].y, bezierPoints[i].x, bezierPoints[i].y);  
    }
  }
  
  PVector getPoint(float x, float y) {
    PVector result = new PVector(-1, -1);
    for (int i = 0; i < size; i++) {
      if (x >= (points[i].x - pointRadius) && x <= (points[i].x + pointRadius) 
      && y >= (points[i].y - pointRadius) && y <= (points[i].y + pointRadius)) {
        result = points[i];
      }
    }
    return result;
  }
  
  void setT(float t) {
    currentT = round(t * maxT);  
  }
  
  void calcSupportDots() {
    supportDots = new PVector[size - 1];
    
    for (int i = 0; i < (size - 1); i++) {
      supportDots[i] = new PVector((points[i + 1].x * (currentT / 100.0)) + (points[i].x * (1 - (currentT / 100.0))), 
      (points[i + 1].y * (currentT / 100.0)) + (points[i].y * (1 - (currentT / 100.0))));  
    }
  }
  
  void drawSupportDots() {
    fill(120);
    noStroke();
    for (int i = 0; i < supportDots.length; i++) {
      ellipse(supportDots[i].x, supportDots[i].y, pointRadius, pointRadius);
      //println(supportDots[i].x + " " + supportDots[i].y);
    }
  }
  
  void drawSupportLines() {
    fill(120);
    stroke(0);
    for (int i = 1; i < supportDots.length; i++) {
      line(supportDots[i-1].x, supportDots[i-1].y, supportDots[i].x, supportDots[i].y);  
    }
  }
  
  void calcBezierSupportDots() {
    PVector[] newSupportDots = new PVector[supportDots.length - 1];  
    
    for (int i = 0; i < newSupportDots.length; i++) {
      newSupportDots[i] = new PVector((supportDots[i + 1].x * (currentT / 100.0)) + (supportDots[i].x * (1 - (currentT / 100.0))), 
      (supportDots[i + 1].y * (currentT / 100.0)) + (supportDots[i].y * (1 - (currentT / 100.0))));  
    }
    
    supportDots = newSupportDots;
  }
  
  void procudeSupportBezier() {
    bezier.calcSupportDots();
    boolean fin = false;
    
    while (!fin) {    
      if (supportDots.length > 1) {
        bezier.drawSupportLines(); 
        bezier.drawSupportDots();
        bezier.calcBezierSupportDots();  
      } else {
        bezier.drawSupportDots();
        fin = true;  
      }
    }
  }
}
