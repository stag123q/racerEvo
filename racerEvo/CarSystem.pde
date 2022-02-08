class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  //ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();
  CarController[] CarControllerList;
  ArrayList<CarController> matingPool;

  int totalFitness, n, generation = 0, highestFit = 0;
  float mutationRate = 0.05;

  //Laver generationen af car controlers
  CarSystem(int populationSize) {
    CarControllerList = new CarController[populationSize];
    for (int i = 0; i < populationSize; i++) { 
      CarControllerList[i] = new CarController();
    }
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
  }

  void updateGA() {

    //Calculates fitness and gets totalFitness
    calcFitness();

    //Creates mating pool
    createMatingPool();

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

  void createMatingPool() {
    ArrayList<CarController> matingPool = new ArrayList<CarController>();

    //Tilføjer hver carcontroller til matingpoolen baseret på fitness
    for (int i = 0; i < CarControllerList.length; i++) {
      int n = int(CarControllerList[i].fitness/totalFitness*1000);
      for (int j = 0; j < n; j++) {
        matingPool.add(CarControllerList[i]);
      }
    }
    
  }

  void crossOver() {
    for (int i = 0; i < CarControllerList.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
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
