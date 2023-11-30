
class Cards {
  int x = -1;
  int y = -1;
  int cardW;
  int cardH;
  color cardColor;
  color backCardColor;

  boolean isPressed;

  boolean isBetween;

  boolean inInButton;

  boolean isFlipped;

  boolean foundMatch;

  boolean isImage;

  PImage img;

  int indexInList;

  /*
  Cards(int startingX, int startingY) {
   
   x = startingX;
   y = startingY;
   cardW = 100;
   cardH = 150;
   cardColor = color(#E8E3C0);
   backCardColor = color(#FF0000);
   isFlipped = false;
   }
   */

  Cards(color givenColor, int givenIndex) {
    cardW = 75;
    cardH = 100;
    cardColor = color(#E8E3C0);
    backCardColor = givenColor;
    indexInList = givenIndex;
    isFlipped = false;
    isImage = false;
  }

  Cards(PImage anImg, int givenIndex) {
    cardW = 75;
    cardH = 100;
    cardColor = color(#E8E3C0);
    indexInList = givenIndex;
    isFlipped = false;
    isImage = true;
    img = anImg;
  }


  void render() {
    if (!isImage) {
      if (!isFlipped) {
        fill(cardColor);
        rect(x, y, cardW, cardH);
      } else {
        fill(backCardColor);
        rect(x, y, cardW, cardH);
        fill(0);
        textAlign(CENTER, CENTER);
        textSize(12);
        text("Sample Text", x+cardW/2, y+cardH/2);
      }
    } else {
      if (!isFlipped) {
        fill(cardColor);
        rect(x, y, cardW, cardH);
      } else {
        image(img, x, y, cardW, cardH);
      }
    }
  }

  boolean isBetween(int num, int min, int max) {
    if (num > min && num < max) {
      return true;
    } else {
      return false;
    }
  }
  boolean isInButton() {
    if (isBetween(mouseX, x, x + cardW) && isBetween(mouseY, y, y + cardH)) {
      return true;
    } else {
      return false;
    }
  }

  boolean isPressed() {
    if (isInButton() && mousePressed) {
      return true;
    } else {
      return false;
    }
  }

  void flip() {
    isFlipped = !isFlipped;
  }

  void givePosn(Posn p) {
    // Posn Example: {150, 30}
    x = p.x;
    y = p.y;
  }

  boolean matchingCard(Cards aCard) {
    boolean isEven;
    if (indexInList % 2 == 0) {
      isEven = true;
    } else {
      isEven = false;
    }

    if (isEven) {
      if (indexInList == aCard.indexInList - 1) {
        foundMatch = true;
        aCard.foundMatch = true;
        return true;
      } else {
        return false;
      }
    } else {
      if (indexInList == aCard.indexInList + 1) {
        foundMatch = true;
        aCard.foundMatch = true;
        return true;
      } else {
        return false;
      }
    }
  }
}
