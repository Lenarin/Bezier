class Slider {
  PVector pos;
  PVector boxPos;
  float value;
  float sliderWidth;
  float sliderHeight = 2;
  float boxSizeHeight = 10;
  float boxSizeWidth = 5;
  boolean hovered = false;
  
  Slider(float x, float y, float newWidth) {
    pos = new PVector(x, y);
    sliderWidth = newWidth;
    value = 1;
    boxPos = new PVector(x + (value * sliderWidth), y);
  }
  
  void drawSlider() {
    fill(200);
    noStroke();
    rectMode(CORNER);
    rect(pos.x, pos.y, sliderWidth, sliderHeight);
    
    stroke(0);
    if (hovered) {
      fill(200);  
    } else {
      fill(255);
    }
    rectMode(CENTER);    
    rect(boxPos.x, boxPos.y, boxSizeWidth, boxSizeHeight);
  }
  
  void updateSlider(float x, float y) {
    if (x >= (boxPos.x - boxSizeWidth / 2) && x <= (boxPos.x + boxSizeWidth / 2) 
    && y >= (boxPos.y - boxSizeHeight / 2) && y <= (boxPos.y + boxSizeWidth / 2)) {
      hovered = true;
    } else if (!mousePressed) {
      hovered = false;  
    }
    
    if (hovered) {
      if ((mousePressed) && (x >= pos.x && x <= pos.x + sliderWidth)) {
        boxPos.x = x;
        value = ((boxPos.x - pos.x) / sliderWidth);
      }
    }
  }
  
  void setValue(float t) {
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    boxPos.x = pos.x + sliderWidth * t;
    value = t;
  }
}
