PImage Aimage;
PImage Cimage;
PImage Dimage;
PImage Fimage;
PImage Kimage;
PImage Simage;
PImage Timage;
PImage Uimage;
PImage appleImage;
PImage carImage;
PImage dogImage;
PImage frogImage;
PImage kiteImage;
PImage schoolBusImage;
PImage treeImage;
PImage UmbrellaImage;

// import sound library
import processing.sound.*;

// declare var to store sound
SoundFile cardFlip;


ArrayList <Cards> cardList;
ArrayList<Cards> primeList;

ArrayList<Posn> posnList;

Cards prime;
boolean isPrimed = false;
boolean isComplete = false;
boolean[] allMatches = new boolean[12];

int state;

int showStart;
int showEnd;
int showTimer;

int wrongStart;
int wrongEnd;
int wrongTimer = 1000;

int indexToFlip;

DifficultyButton easyButton;
DifficultyButton mediumButton;
DifficultyButton hardButton;

String chosenDifficulty;

/*

 Array of n/2 colors
 
 boolean array of size n, all set to false
 
 for each color in the array, assign it to two random
 
 */


void setup() {
  size(800, 600);

  //initialize the sound variable
  cardFlip = new SoundFile(this, "cardFlip.wav");

  cardList = new ArrayList <Cards>();
  primeList = new ArrayList<Cards>();

  posnList = new ArrayList<Posn>();

  //println("CARD LIST SIZE: " + cardList.size());

  easyButton = new DifficultyButton(50, 120, 200, 80, "EASY");
  mediumButton = new DifficultyButton(300, 120, 200, 80, "MEDIUM");
  hardButton = new DifficultyButton(550, 120, 200, 80, "HARD");

  state = 0;

  showStart = millis();
  showTimer = 3000;

  wrongStart = millis();

  // image intitialization
  appleImage = loadImage("AppleImage.png");
  carImage = loadImage("CarImage.png");
  dogImage = loadImage("DogImage.png");
  frogImage = loadImage("FrogImage.png");
  kiteImage = loadImage("KiteImage.png");
  schoolBusImage = loadImage("SchoolBusImage.png");
  treeImage = loadImage("TreeImage.png");
  UmbrellaImage = loadImage("UmbrellaImage.png");

  //appleImage.resize(appleImage.width/2, appleImage.height/2);
  //Cimage;
  //Dimage;
  //Fimage;
  //Kimage;
  //Simage;
  //Timage;
  //Uimage;
  
  Aimage = loadImage("A.png");
  Cimage = loadImage("C.png");
  Dimage = loadImage("D.png");
  Fimage = loadImage("F.png");
  Kimage = loadImage("K.png");
  Simage = loadImage("S.png");
  Timage = loadImage("T.png");
  Uimage = loadImage("U.png");


  /* TESTING ENVIRONMENT */
}

void draw() {
  background(0);
  checkCompletion();

  showEnd = millis();
  wrongEnd = millis();

  switch (state) {
  case 0: // start screen

    textAlign(CENTER, CENTER);
    textSize(60);
    text("Choose an option to start", width/2, height/2);
    easyButton.render();
    mediumButton.render();
    hardButton.render();
    showStart = millis();
    break;
  case 1: // show cards screen

    if (showEnd - showStart < showTimer) {
      for (Cards eachCard : cardList) {
        eachCard.isFlipped = true;
        eachCard.render();
      }
    } else {
      state = 2;
      for (Cards eachCard : cardList) {
        eachCard.isFlipped = false;
      }
    }

    break;
  case 2: // play screen

    for (Cards eachCard : cardList) {

      if (eachCard.foundMatch) {
        allMatches[eachCard.indexInList] = true;
      }

      eachCard.render();

      //println("SIZE OF POSN LIST: " + posnList.size());
    }

    if (isPrimed) {
      //delay(1000);
      Cards prime1 = primeList.get(0);
      Cards prime2 = primeList.get(1);
      boolean doTheyMatch = prime1.matchingCard(prime2);

      if (doTheyMatch) {
        clearPrimeList();
        isPrimed = false;
        println("WE HAVE A MATCH");
      } else {
        if (wrongEnd - wrongStart > wrongTimer) {
          prime1.flip();
          prime2.flip();
          println("THEY DONT MATCH SILLYYYY");

          clearPrimeList();
          isPrimed = false;
        }
      }
    }

    if (isComplete) {
      state = 3;
    }

    break;
  case 3: // win screen
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(80);
    text("You win!", width/2, height/2);
    textSize(40);
    text("Press 'r' to restart", width/2, height/2 + 60);
    break;
  }
}

void mousePressed() {
  for (Cards eachCard : cardList) {

    if (eachCard.isInButton()) {

      cardFlip.play();
      eachCard.flip();

      if (primeList.size() < 1) {
        primeList.add(eachCard);
      } else if (primeList.size() == 1) {
        primeList.add(eachCard);
        isPrimed = true;
        wrongStart = millis();
      }
    }
  }

  if (state == 0) {
    if (easyButton.isInButton()) {
      chosenDifficulty = "EASY";
      createGame();
      state = 1;
    } else if (mediumButton.isInButton()) {
      chosenDifficulty = "MEDIUM";
      createGame();
      state = 1;
    } else if (hardButton.isInButton()) {
      chosenDifficulty = "HARD";
      createGame();
      state = 1;
    }
  }
}

void keyPressed() {
  if (key == 'r' && state == 3) {
    state = 0;
  }
}

void checkCompletion() {

  for (int i = 0; i < allMatches.length; i++) {
    if (!allMatches[i]) {
      isComplete = false;
      return;
    }
  }

  isComplete = true;
  return;
}

void clearPrimeList() {
  while (primeList.size() > 0) {
    primeList.remove(0);
  }
}

void resetEverything() {
  posnList = new ArrayList<Posn>();
  posnList.add(new Posn(150, 30));
  posnList.add(new Posn(150, 230));
  posnList.add(new Posn(150, 425));
  posnList.add(new Posn(280, 30));
  posnList.add(new Posn(280, 230));
  posnList.add(new Posn(280, 425));
  posnList.add(new Posn(408, 30));
  posnList.add(new Posn(408, 235));
  posnList.add(new Posn(408, 425));
  posnList.add(new Posn(535, 30));
  posnList.add(new Posn(535, 235));
  posnList.add(new Posn(535, 425));

  println("CARD LIST SIZE: " + cardList.size());

  boolean[] newArray = new boolean[12];
  allMatches = newArray;

  for (Cards aCard : cardList) {
    int max = posnList.size();
    int index = int(random(0, max));

    Posn p = posnList.get(index);
    posnList.remove(index);

    aCard.givePosn(p);
    aCard.foundMatch = false;
  }
}

void createGame() {

  emptyCardList();

  if (chosenDifficulty == "EASY") { // 8 cards

    boolean[] newArray = new boolean[8];
    allMatches = newArray;

    color[] colorArray = { color(255, 105, 97), color(248, 243, 141), color(66, 214, 164), color(89, 173, 246) };

    cardList.add(new Cards(appleImage, 0));
    cardList.add(new Cards(Aimage, 1));
    cardList.add(new Cards(carImage, 2));
    cardList.add(new Cards(Cimage, 3));
    cardList.add(new Cards(dogImage, 4));
    cardList.add(new Cards(Dimage, 5));
    cardList.add(new Cards(treeImage, 6));
    cardList.add(new Cards(Timage, 7));

    posnList.add(new Posn(138, 163));
    posnList.add(new Posn(138, 337));
    posnList.add(new Posn(288, 163));
    posnList.add(new Posn(288, 337));
    posnList.add(new Posn(437, 163));
    posnList.add(new Posn(437, 337));
    posnList.add(new Posn(587, 163));
    posnList.add(new Posn(587, 337));
  } else if (chosenDifficulty == "MEDIUM") { // 12 cards

    boolean[] newArray = new boolean[12];
    allMatches = newArray;

    color[] colorArray = { color(255, 105, 97), color(255, 180, 128), color(248, 243, 141), color(66, 214, 164), color(89, 173, 246), color(199, 128, 232) };

    cardList.add(new Cards(appleImage, 0));
    cardList.add(new Cards(Aimage, 1));
    cardList.add(new Cards(carImage, 2));
    cardList.add(new Cards(Cimage, 3));
    cardList.add(new Cards(dogImage, 4));
    cardList.add(new Cards(Dimage, 5));
    cardList.add(new Cards(frogImage, 6));
    cardList.add(new Cards(Fimage, 7));
    cardList.add(new Cards(UmbrellaImage, 8));
    cardList.add(new Cards(Uimage, 9));
    cardList.add(new Cards(treeImage, 10));
    cardList.add(new Cards(Timage, 11));

    posnList.add(new Posn(138, 75));
    posnList.add(new Posn(138, 250));
    posnList.add(new Posn(138, 425));
    posnList.add(new Posn(288, 75));
    posnList.add(new Posn(288, 250));
    posnList.add(new Posn(288, 425));
    posnList.add(new Posn(437, 75));
    posnList.add(new Posn(437, 250));
    posnList.add(new Posn(437, 425));
    posnList.add(new Posn(587, 75));
    posnList.add(new Posn(587, 250));
    posnList.add(new Posn(587, 425));
  } else if (chosenDifficulty == "HARD") { // 16 cards

    boolean[] newArray = new boolean[16];
    allMatches = newArray;

    color[] colorArray = { color(255, 105, 97), color(255, 180, 128), color(248, 243, 141), color(66, 214, 164), color(8, 202, 209), color(89, 173, 246), color(157, 148, 255), color(199, 128, 232) };

    cardList.add(new Cards(appleImage, 0));
    cardList.add(new Cards(Aimage, 1));
    cardList.add(new Cards(carImage, 2));
    cardList.add(new Cards(Cimage, 3));
    cardList.add(new Cards(dogImage, 4));
    cardList.add(new Cards(Dimage, 5));
    cardList.add(new Cards(frogImage, 6));
    cardList.add(new Cards(Fimage, 7));
    cardList.add(new Cards(kiteImage, 8));
    cardList.add(new Cards(Kimage, 9));
    cardList.add(new Cards(schoolBusImage, 10));
    cardList.add(new Cards(Simage, 11));
    cardList.add(new Cards(treeImage, 12));
    cardList.add(new Cards(Timage, 13));
    cardList.add(new Cards(UmbrellaImage, 14));
    cardList.add(new Cards(Uimage, 15));

    posnList.add(new Posn(138, 40));
    posnList.add(new Posn(138, 180));
    posnList.add(new Posn(138, 320));
    posnList.add(new Posn(138, 460));
    posnList.add(new Posn(288, 40));
    posnList.add(new Posn(288, 180));
    posnList.add(new Posn(288, 320));
    posnList.add(new Posn(288, 460));
    posnList.add(new Posn(437, 40));
    posnList.add(new Posn(437, 180));
    posnList.add(new Posn(437, 320));
    posnList.add(new Posn(437, 460));
    posnList.add(new Posn(587, 40));
    posnList.add(new Posn(587, 180));
    posnList.add(new Posn(587, 320));
    posnList.add(new Posn(587, 460));
  }

  println(cardList.size());

  for (Cards aCard : cardList) {
    int max = posnList.size();
    int index = int(random(0, max));

    Posn p = posnList.get(index);
    posnList.remove(index);

    aCard.givePosn(p);
  }
}

void emptyCardList() {
  for (int i = cardList.size() - 1; i >= 0; i--) {
    cardList.remove(0);
  }
}
