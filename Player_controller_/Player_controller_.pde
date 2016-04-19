/*
this program is my attempt at recreating asteroids offline without reference.
*/



class Walker {
  //mover group variables
  PVector location; 
  PVector velocity;
  PVector acceleration;
  PVector direction;
  PVector target;
  float speed;
  
  //bullet group variables
  PVector bulletDirection;
  PVector bulletLocation;
  PVector bulletVelocity;
  PVector bulletAcceleration;
  float bulletSpeed;
  
  //basic variables
  int size;
  int theta;
  
  //state initialisers for movement
  boolean accelerateForward;
  boolean accelerateBackward;
  boolean rotateClockwise;
  boolean rotateAntiClockwise;
  
  
  Walker() {
    //initial variables
    theta = 0;
    location = new PVector(width/2, height/2);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    bulletVelocity = new PVector(0, 0);
    bulletLocation = new PVector(width/2, height/2);
    bulletAcceleration = new PVector (0,0);
   
    speed = 0;
    //initial states
    accelerateForward = false;
    accelerateBackward = false;
    rotateClockwise = false;
    rotateAntiClockwise = false;
  }
    void move() {
      //movement and acceleration algorithm
      target = new PVector(location.x + cos(theta*0.1)*75, location.y + sin(theta*0.1)*75);
      velocity.add(acceleration);
      location.add(velocity);
      velocity.limit(5);
      direction = PVector.sub(target, location);
      direction.normalize();
      direction.mult(speed/4);
      direction.limit(.05);
      acceleration = direction;
      
      //bullet movement algorithm
      bulletVelocity.add(bulletAcceleration);
      bulletLocation.add(bulletVelocity);
      bulletDirection = PVector.sub(target, location);
      bulletDirection.normalize();
      bulletDirection.mult(bulletSpeed);
      bulletAcceleration = bulletDirection;
     
      //screen loop function
      if (location.x > width) {
        location.x = 0;
      } else if (location.x < 0 ) {
        location.x = width;
      } else if (location.y > height) {
        location.y = 0;
      } else if (location.y < 0) {
        location.y = height;
      }
      
      if (keyPressed) {
        //this.keyPressed();
        this.shoot();
      } else {
        speed = 0;
      }
      
      if (accelerateForward) {
        speed += 0.05;
      } else if ( accelerateBackward) {
        speed -= 0.02;
      } else { 
        speed = 0;
      }
      if (rotateClockwise) {
        theta +=1;
      } else if (rotateAntiClockwise) {
        theta -= 1;
      } else {
        theta = 0;
      }
    }
    
    void keypressed() {
      if ((key == 'w') || (key == 'W') || (keyCode == UP)) { //if up
        accelerateForward = true;
        println("hi");
        } 
      //reverse statement
      if ((key == 's') || (key == 'S') || (keyCode == DOWN)) {
        accelerateBackward = true;  
      } 
      // rotate anti-clockwise statement
      if ((key == 'a') || (key == 'A') || (keyCode == LEFT)) {
        rotateAntiClockwise = true;
      } 
      // rotate clockwise statement
      if ((key == 'd') || (key == 'D') || (keyCode == RIGHT)) {
        rotateClockwise = true;
      }
   }
   void keyReleased() {
      if (key == 'w' || key == 'W' || keyCode == UP) {
        accelerateForward = false;
      }
      if (key =='s' || key == 'S' || keyCode == DOWN) {
        accelerateBackward = false;
      }
      if (key == 'a' || key == 'A' || keyCode == LEFT) {
        rotateAntiClockwise = false;
      }
      if (key == 'd' || key == 'D' || keyCode == RIGHT) {
        rotateClockwise = false; 
      }
   }

  // this function contains all the controls and outputs
  /*void  control() { 
     
      if ((key == 'w') || (key == 'W') || (keyCode == UP)) { //if up
      accelerationState = 1;
          speed += 0.05;
      //reverse statement
      } 
      if ((key == 's') || (key == 'S') || (keyCode == DOWN)) {
        accelerationState = 2;
          speed -= 0.02;
      // rotate anti-clockwise statement
      } 
      if ((key == 'a') || (key == 'A') || (keyCode == LEFT)) {
        theta -= 1;
      // rotate clockwise statement
      } 
      if ((key == 'd') || (key == 'D') || (keyCode == RIGHT)) {
          theta += 1;
      }
      
    }
  }*/
  
  void shoot () {
    if (keyPressed) {
      if (key == ' ') {
        bulletSpeed = 1;
      }
    }
  }
  
  void display() {
    noFill();
    stroke(0, 100, 200);
    strokeWeight(1);
    triangle(location.x + cos(theta*0.1)* 25, location.y + sin(theta*0.1)* 25, location.x + cos(theta*0.1 - 90)* 10, location.y + sin(theta*0.1 -90)* 10, location.x + cos(theta*0.1 + 90)* 10, location.y + sin(theta*0.1 + 90)* 10);
    
    strokeWeight(10);
    stroke(0);
    point(bulletLocation.x, bulletLocation.y);
    println(accelerateForward);
    println(accelerateBackward);
    println(rotateClockwise);
    println(rotateAntiClockwise);
  }
}


Walker walker = new Walker();

void setup(){
  size(500, 800); 
  frameRate(120);
}
  
void draw() {
  background(255);
  walker.move();
  walker.keypressed();
  walker.keyReleased();
  walker.display(); 
  
}