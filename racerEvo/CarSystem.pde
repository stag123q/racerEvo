class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  //ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();
  CarController[] CarControllerList;
  ArrayList<CarController> matingPool;

  int totalFitness, ratio;
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
  }

  void calcFitness() {
    totalFitness = 0;

    for (int i = 0; i < CarControllerList.length; i++) {
      CarControllerList[i].Fitness();
    }

    for (int i = 0; i < CarControllerList.length; i++) {
      totalFitness = CarControllerList[i].fitness + totalFitness;
    }
  }

  void createMatingPool() {
    ArrayList<CarController> matingPool = new ArrayList<CarController>();
    
    //Sætter en ratio der giver det rigtige størrelsesforhold at gange på fitnessen for at få en matingpool der ikke er for stor/lille
    int tfLength = str(totalFitness).length();
    String ratioSTR = "1";
     
    for(int i = 0; i < tfLength; i++){
      ratioSTR = ratioSTR + 0;
    }
    
    ratio = int(ratioSTR);

    
    //Tilføjer hver carcontroller til matingpoolen baseret på fitness
    for (int i = 0; i < CarControllerList.length; i++) {
      int n = CarControllerList[i].fitness*(ratio/totalFitness);
      print(n, "||");
      for (int j = 0; j < n; j++) {
        matingPool.add(CarControllerList[i]);
      }
    }

    print("matingpools størrelse:", matingPool.size());
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
}
