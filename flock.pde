class Flock {
 ArrayList<Boid> boids = new ArrayList<Boid>();
 
 Flock(int num) {
   for (int i = 0; i < num; i++) {
     boids.add(new Boid()); 
   }
 }
 
 
 void draw() {
   for (Boid boid: boids) {
     boid.show(); 
   }
 }
 
 void drawPretty() {
   for (Boid boid: boids) {
     boid.drawPretty();
   }
 }
 
 
 
 void target(PVector target) {
   for (Boid boid: boids) {
     boid.target(target, 100);
   }
 }
 
 void move() {
   for (Boid boid: boids) {
     boid.move(); 
   }
 }
}
