import processing.sound.*;
SoundFile song;
SoundFile song1;
boolean s;
float x, y, speedX, speedY;
float diam = 30;
float rectSize = 200;
int point;
boolean play;
FFT fft;
int NUM_BANDS = 256;
float baseLine;
void setup() {
  size(600, 400);
  point = 0;
  play = false;
  textSize(50);
  fft = new FFT(this, NUM_BANDS);
  fft.input(song);
  reset();
  s = false;
  song = new SoundFile(this, "bsong.mp3");
  song.amp(0.2);
  song1 = new SoundFile(this, "hit.mp3");
  song1.amp(0.6);

  fft = new FFT(this, NUM_BANDS);
  fft.input(song);
  song.loop();
}
void reset() {
  x = width/2;
  y = height/2;
  speedX = 5;
  speedY = 5;
  point = 0;
}

void draw() {

  noStroke();
  fill(240, 255, 255, 5);
  rect(0, 0, width, height);


  stroke(0, 0, 0);
  strokeWeight(0.3);

  fft.analyze();

  beginShape();
  for (int i=0; i<fft.spectrum.length*0.4; i=i+1)
  {
    float xPos = map(i, 0, fft.spectrum.length*0.4, 10, width-10);
    float yPos = map(sqrt(fft.spectrum[i]), 0, 1, baseLine, baseLine-height*0.7);
    vertex(xPos, yPos);
  }
  endShape();


  baseLine++;
  if (baseLine > height-10)
  {
    baseLine = 20;
  }
  fill(255, 140, 130);
  text("Click Key", 200, 200);

  if (play) {

    background(#E87C7E+point*8);
    fill(#59E6F5);
    textSize(90);
    text(point, 280, height/2);

    fill(0, 0, 255);
    circle(x, y, diam);

    rect(width-30, mouseY-rectSize/2, 10, rectSize-100);

    x += speedX;
    y += speedY;

    if (x>610) {
      reset();
    }


    if ( x > width-50 && x < width -20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2-100 ) {
      speedX = speedX * -1.05;
      speedY = speedY * 1.05;
      song1.play();
      point+= 1;
    }
    if (x < 25) {
      speedX *= -1.1;
      speedY *= 1.1;
      x += speedX;
    }


    if ( y > height || y < 0 ) {
      speedY *= -1;
    }
  }
  if (point ==10) {
    background(255);
    text("gameover", 100, 100);
    text("Score = ", 100, 200);
    text(point, 400, 200);
  }
}

void keyPressed() {
  play = true;
}

void mousePressed() {
  reset();
}
