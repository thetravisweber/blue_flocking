Flock f;
float bound = 1.1;
boolean targetMouse = false;

void setup() {
  size(800, 600);
  fullScreen();
  f = new Flock(800);
  background(0);
}

void draw() {
  //background(0);
  f.move();
  if (frameCount % 2 == 0) {
    f.drawPretty();
  }
  if (targetMouse)
  {
    f.target(new PVector(mouseX, mouseY)); 
  }
}

void mousePressed() {
  targetMouse = true;
}

void mouseReleased() {
  targetMouse = false;
}

void keyPressed() {
  if (key == 's') {
    saveFrame("flocking-image-#####.png");
  }
}
