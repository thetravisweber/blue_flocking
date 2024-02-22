class Boid {
  PVector pos;
  PVector vel = new PVector(0, 0);
  PVector acc = new PVector(0, 0);
  float id = random(-100000, 1000000);
  float angle;
  float w = 8;
  float h = 30;
  float offset = random(1000);
  float view = 100;
  float personalSpace = 30;
  float farView = 150;
  
  Boid() {
    pos = new PVector(random(width), random(height));
    angle = random(TWO_PI);
  }
  
  void show() {
   float x = pos.x;
   float y = pos.y;
   PVector head = new PVector(cos(angle) * h + x, y - sin(angle) * h);
   float left = angle + PI / 2;
   float right = angle - PI / 2;
   PVector leftTail = new PVector(cos(left) * w + x, y - sin(left) * w);
   PVector rightTail = new PVector(cos(right) * w + x, y - sin(right) * w);
   triangle(head.x, head.y, leftTail.x, leftTail.y, rightTail.x, rightTail.y); 
  }
  
  void drawPretty() {
    stroke(0, 137, 255, 5);
    strokeWeight(1);
    for (Boid friend: f.boids) {
      if (friend.id == this.id) {
        continue; 
      }
      if (this.pos.dist(friend.pos) < this.view) {
        line(this.pos.x, this.pos.y, friend.pos.x, friend.pos.y);
      }
    }
  }
  
  void force(PVector force) {
    acc.add(force);
  }
  
  void turn(float theta) {
    angle += theta; 
  }
  
  void target(PVector target, float strength) {
    PVector dir = PVector.sub(target, pos);
    this.force(dir.div(10000 / strength));
  }
  
  void repel(PVector target, float strength) {
    PVector dir = PVector.sub(target, pos);
    this.force(dir.div(-10000 / strength ));
  }
  
  void update() {
    vel.add(acc.div(5));
    pos.add(vel.div(1.1));
    PVector target = new PVector(vel.x, vel.y * -1);
    angle = target.heading();
    
    if (this.pos.x < width - width * bound) {
      this.pos.x = width * bound;
    } else if (this.pos.x > width * bound) {
      this.pos.x = width - width * bound; 
    }
    
    if (this.pos.y < height - height * bound) {
      this.pos.y = height * bound;
    } else if (this.pos.y > height * bound) {
      this.pos.y = height - height * bound; 
    }
  }
  
  
  void move() {
     this.interactWithFlock(1);
     this.goWithTheFlow(4);
     
     this.update();
  }
  
  void interactWithFlock(float strength) {
    for (Boid friend : f.boids) {
       if (friend.id == this.id) {
          continue;
       }
       
       float dist = this.pos.dist(friend.pos);
       if (dist < this.personalSpace ) {
         this.repel(friend.pos, 100 * strength);
       } else if (dist < this.view) {
         this.target(friend.pos, strength);
       } else if (dist < this.farView) {
        this.target(friend.pos, strength / 5);
       }
     }
  }
  
  void goWithTheFlow(float strength) {
    PVector force = new PVector(
      (noise(frameCount / 10 + this.offset) - .5) * strength, 
      (noise(frameCount / 10 + this.offset + 10000) - .5) * strength
    );
    
    this.force(force);
  }
}
