class DifficultyButton{
  int x;
  int y;
  int w;
  int h;
  color cardColor;
  String difficulty;
  
  DifficultyButton (int aX, int aY, int aW, int aH, String aDifficulty){
    x = aX;
    y = aY;
    w = aW;
    h = aH;
    difficulty = aDifficulty;
    if (difficulty == "EASY"){
      cardColor = color(0,120,0);
    }
    else if (difficulty == "MEDIUM"){
      cardColor = color(120,120,0);
    }
    else if (difficulty == "HARD"){
      cardColor = color(120,0,0);
    }
    else { // something went wrong, difficulty was not easy, medium, or hard
      cardColor = color(0);
      difficulty = "UH OH";
    }
  }
  
  void render(){
    fill(cardColor);
    rect(x,y,w,h,20);
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(24);
    text(difficulty,x+w/2,y+h/2);
  }
  
  boolean isBetween(int min, int n, int max){
    return min <= n && n <= max;
  }
  
  boolean isInButton(){
    return isBetween(x,mouseX,x+w) && isBetween(y,mouseY,y+h);
  }
}
