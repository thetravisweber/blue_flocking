Flock f;
float bound = 1.1;

void setup() {
  //size(800, 600);
  fullScreen();
  f = new Flock(500);
  background(0);
}

void draw() {
  //background(0);
  f.move();
  //f.draw();
  //if (frameCount % 5 == 0) {
    f.drawPretty();
  //}
}

void mousePressed() {
 f.target(new PVector(mouseX, mouseY)); 
}
