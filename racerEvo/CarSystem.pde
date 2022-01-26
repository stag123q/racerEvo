class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  //ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();
  CarController[] CarControllerList;
  ArrayList<CarController> matingPool;

  int totalFitness, n;
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
    for (int i = 0; i < CarControllerList.length; i++) {
      CarControllerList[i].Fitness();
    }

    ArrayList<CarController> matingPool = new ArrayList<CarController>();

    for (int i = 0; i < CarControllerList.length; i++) {
      totalFitness += CarControllerList[i].fitness;
    }

    //Tilføj hver carcontroller til matingpoolen baseret på fitness
    for (int i = 0; i < CarControllerList.length; i++) {
      int n = int(CarControllerList[i].fitness/totalFitness*100);
      for (int j = 0; j < n; j++) {
        matingPool.add(CarControllerList[i]);
      }
    }
    for (int i = 0; i < CarControllerList.length; i++) {
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));
      CarController partnerA = matingPool.get(a);
      CarController partnerB = matingPool.get(b);
      CarController child = partnerA.Crossover(partnerB);
      child.Mutate(mutationRate);

      CarControllerList[i] = child;
    }

    totalFitness = 0;
  }
}
