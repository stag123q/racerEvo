class Car {  
  //Bil - indeholder position & hastighed & "tegning"
  PVector pos = new PVector(100, 280);
  PVector vel = new PVector(0, 15);
  
  void turnCar(float turnAngle){
    vel.rotate(turnAngle);
  }

  void displayCar() {
    stroke(100);
    fill(100);
    ellipse(pos.x, pos.y, 10, 10);
  }
  
  void update() {
    pos.add(vel);
  }
  
}
