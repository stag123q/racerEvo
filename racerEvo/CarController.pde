class CarController {
  //Forbinder - Sensorer & Hjerne & Bil
  float varians = 2, normWhiteCol = 0, normLaptime = 0; //hvor stor er variansen på de tilfældige vægte og bias
  int fitness = 0, whiteCol = 0, whiteColPoints = 0, laptimePoints = 0;
  Car bil                    = new Car();
  NeuralNetwork hjerne       = new NeuralNetwork(varians); 
  SensorSystem  sensorSystem = new SensorSystem();

  void update() {
    //1.)opdtarer bil 
    bil.update();
    //2.)opdaterer sensorer    
    sensorSystem.updateSensorsignals(bil.pos, bil.vel);
    //3.)hjernen beregner hvor meget der skal drejes
    float turnAngle = 0;
    float x1 = int(sensorSystem.leftSensorSignal);
    float x2 = int(sensorSystem.frontSensorSignal);
    float x3 = int(sensorSystem.rightSensorSignal);    
    turnAngle = hjerne.getOutput(x1, x2, x3);    
    //4.)bilen drejes
    bil.turnCar(turnAngle);
  }

  void display() {
    bil.displayCar();
    sensorSystem.displaySensors();
  }


  void Fitness() {

    fitness = int(sensorSystem.clockWiseRotationFrameCounter);
    
    if (fitness < 0) fitness = 0;
  }

  CarController Crossover(CarController partner) {
    CarController child = new CarController();

    //Laver en crossover mellem weights
    for (int i = 0; i < hjerne.weights.length; i++) {
      float a = hjerne.weights[i];
      float b = partner.hjerne.weights[i];

      if (a < b) child.hjerne.weights[i] = random(a, b);
      if (a > b) child.hjerne.weights[i] = random(b, a);
      else child.hjerne.weights[i] = a;
    }
    //Laver en crossover mellem biases
    for (int i = 0; i < hjerne.biases.length; i++) {
      float a = hjerne.biases[i];
      float b = partner.hjerne.biases[i];

      if (a < b) child.hjerne.biases[i] = random(a, b);
      if (a > b) child.hjerne.biases[i] = random(b, a);
      else child.hjerne.weights[i] = a;
    }
    return child;
  }

  void Mutate(float mutationRate) {
    //Muterer weights
    for (int i = 0; i < hjerne.weights.length; i++) {
      if(random(1) < mutationRate){
        hjerne.weights[i] = int(random(-varians, varians));
      }
    }
    //Muter biases
        for (int i = 0; i < hjerne.biases.length; i++) {
      if(random(1) < mutationRate){
        hjerne.biases[i] = int(random(-varians, varians));
      }
    }
  }
}
