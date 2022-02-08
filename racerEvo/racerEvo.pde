//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 500, genLength = 15;     

Boolean autoUpdate = true, sensorView = false, crashedCarView = false;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(1920, 1080);
  trackImage = loadImage("track.JPG");
}

void draw() {
  clear();
  //fill(255);
  //rect(0,50,1000,1000);
  background(255);
  image(trackImage, 0, 80, 982, 878);  

  carSystem.updateAndDisplay();
  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 200 frame - f.eks. dem der kører uden for banen
  /* if (frameCount%200==0) {
   println("FJERN DEM DER KØRER UDENFOR BANEN frameCount: " + frameCount);
   for (int i = carSystem.CarControllerList.size()-1 ; i >= 0;  i--) {
   SensorSystem s = carSystem.CarControllerList.get(i).sensorSystem;
   if(s.whiteSensorFrameCount > 0){
   carSystem.CarControllerList.remove(carSystem.CarControllerList.get(i));
   }
   }
   }*/

  for (int i = carSystem.CarControllerList.length-1; i >= 0; i--) {
    SensorSystem s = carSystem.CarControllerList[i].sensorSystem;
    if (s.whiteSensorFrameCount > 0) {
      carSystem.CarControllerList[i].out = true;
    }
  }


      drawUI();
    }

    void drawUI() {
      fill(0);
      rect(1280, 15, 600, 660);
      fill(255);
      textSize(35);
      text("S to toggle sensor view", 1300, 600);
      text("C to toggle crashed car view", 1300, 650);
      text("Population size: "+populationSize, 1300, 500);
      text("Generations: "+carSystem.generation, 1300, 450);
      text("Mutation rate: "+carSystem.mutationRate*100+"%", 1300, 400);
      text("Highest fitness: "+carSystem.highestFit, 1300, 350);
      text("SPACE to start new gen", 1300, 250);
      text("BACKSPACE to restart", 1300, 200);


      //rect(0,0,300,400);

      text("U to enable automatic new gen", 1300, 50);

      if (autoUpdate) {
        text("Automatic generations: Every "+genLength+"s", 1300, 100);
      } else {
        text("Automatic generations: Disabled", 1300, 100);
      }
    }

    void keyReleased() {
      //Hvis n trykkes, generationen øges med 1
      if (keyCode == 32) {
        carSystem.updateGA();
        carSystem.m = 0;
      }
      if (keyCode == 8) {
        carSystem = new CarSystem(populationSize);
      }
      if (keyCode == 85) {
        autoUpdate = !autoUpdate;
      }
      if (keyCode == 83) {
        sensorView = !sensorView;
      }
      if (keyCode == 67) {
        crashedCarView = !crashedCarView;
      }
    }
