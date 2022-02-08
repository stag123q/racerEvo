class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  //ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();
  CarController[] CarControllerList;
  ArrayList<CarController> matingPool;


  int totalFitness, ratio, generation = 1, highestFit = 0, m = millis(), time;


  float mutationRate = 0.05;

  //Laver generationen af car controlers
  CarSystem(int populationSize) {
    CarControllerList = new CarController[populationSize];
    for (int i = 0; i < populationSize; i++) { 
      CarControllerList[i] = new CarController();
    }
    time = millis();
  }

  void updateAndDisplay() {

    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();
    }


    if (m == 5000) {
      for (int i = 0; i < CarControllerList.length; i++) {
        if (CarControllerList[i].bil.pos.x < 400 && CarControllerList[i].bil.pos.x < 500) CarControllerList[i].cornerStraf = 0.05;
       }
      }

    if (millis() > time + 15000 && autoUpdate == true) {
      updateGA();
      m = 0;
      time = millis();
    }
  }

  void updateGA() {
    //Calculates fitness and gets totalFitness
    calcFitness();

    //Crossover
    crossOver();

    generation++;
    
  }

  void calcFitness() {

    highestFit = 0;

    //calcs all fitness scores. Also gets highest fitness

    for (int i = 0; i < CarControllerList.length; i++) {
      CarControllerList[i].Fitness();

      if (CarControllerList[i].fitness > highestFit) {
        highestFit = CarControllerList[i].fitness;
      }
    }


    //sums fitness scores into totalFitness

    for (int i = 0; i < CarControllerList.length; i++) {
      totalFitness = CarControllerList[i].fitness + totalFitness;
    }
    
  }

  void crossOver() {
    //Laver først matingpool
    ArrayList<CarController> matingPool = new ArrayList<CarController>();

    //Sætter en ratio der giver det rigtige størrelsesforhold at gange på fitnessen for at få en matingpool der ikke er for stor/lille
    int tfLength = str(totalFitness).length();
    String ratioSTR = "1";

    for (int i = 0; i < tfLength; i++) {
      ratioSTR = ratioSTR + 0;
    }

    ratio = int(ratioSTR);


    //Tilføjer hver carcontroller til matingpoolen baseret på fitness
    for (int i = 0; i < CarControllerList.length; i++) {
      int n = CarControllerList[i].fitness*(ratio/totalFitness);
      for (int j = 0; j < n; j++) {
        matingPool.add(CarControllerList[i]);
      }
    }

    for (int i = 0; i < CarControllerList.length; i++) {
      int ms = matingPool.size();
      int a = int(random(ms));
      int b = int(random(ms));
      CarController partnerA = matingPool.get(int(a));
      CarController partnerB = matingPool.get(int(b));
      CarController child = partnerA.Crossover(partnerB);
      child.Mutate(mutationRate);

      CarControllerList[i] = child;
    }

    totalFitness = 0;
  }

  void restart () {
    generation = 0;

    CarControllerList = new CarController[populationSize];
    for (int i = 0; i < populationSize; i++) { 
      CarControllerList[i] = new CarController();
    }
  }
}
