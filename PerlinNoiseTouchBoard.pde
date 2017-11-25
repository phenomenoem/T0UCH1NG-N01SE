import processing.serial.*;

Serial port;

String serialDataFromTouchBoard;

int[] arrayOfTouchBoardData;
int[][] dataSmoother = {  { 0, 0, 0, 0, 0 }, //E0
  { 0, 0, 0, 0, 0 }, //E1
  { 0, 0, 0, 0, 0 }, //E2
  { 0, 0, 0, 0, 0 }, //E3
  { 0, 0, 0, 0, 0 }, //E4
  { 0, 0, 0, 0, 0 }, //E5
  { 0, 0, 0, 0, 0 }, //E6
  { 0, 0, 0, 0, 0 }, //E7
  { 0, 0, 0, 0, 0 }, //E8
  { 0, 0, 0, 0, 0 }, //E9
  { 0, 0, 0, 0, 0 }, //E10
  { 0, 0, 0, 0, 0 }   //E11
};
int[] smoothedData = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
int counter;

int mxw = 1200;
int myh = 800;
float x, y;
float u = 0;
float v = 0;
float x0, y0, dx, dy;
float coefx, coefy, coefz;
boolean isAlive = false;
boolean isColor = true;
boolean isSmooth = true;
boolean isLoop = true;

int NumP = 400;
float Npi;

void settings () {
  size(mxw, myh);
} 
void setup() {
  String touchBoardPort = Serial.list()[7];
  port = new Serial(this, touchBoardPort, 9600);

  Npi = 4; 
  coefx = 0.005; 
  coefy = 0.007;
  coefz = 0.009;

  background(255, 255, 255);

  if (isSmooth) {
    smooth();
  }
}

void draw() {

  if (port.available() > 0) {
    serialDataFromTouchBoard = port.readString();
    parseSerialDataFromTouchBoard(serialDataFromTouchBoard);
  }

  for (int n = 0; n <= NumP; n++) {
    if (isAlive) {
      float nv = noise(x * coefx, y * coefy, (frameCount * 0.1) * coefz);
      if (isColor) {
        float mysin = sin((nv - 0.3) * TWO_PI * Npi);
        float mycos = cos((nv - 0.3) * TWO_PI * Npi);
        if (mycos >= 0 & mysin >= 0) fill(0);
        if (mycos >= 0 & mysin < 0) fill(0);
        if (mycos < 0 & mysin >= 0) fill(0);
        if (mycos < 0 & mysin < 0) fill(0);
      } else {
        fill(10, 10);
      }
      u = u + cos((nv-0.3)*TWO_PI*Npi);
      v = v + sin((nv-0.3)*TWO_PI*Npi);
      u = u / 2;
      v = v / 2;
      x = x + u;
      y = y + v;
    } else {
      x0 = 0.5 * mxw;
      y0 = 0.5 * myh;
      x = x0; 
      y = y0;
      dx = 100 * frameCount / 2000+50;
      dy = dx;
      isAlive = true;
    }
    noStroke();
    ellipse(x, y, map(smoothedData[0], 80, 420, 0, 0.75), map(smoothedData[0], 80, 420, 0, 0.75));
  }
  if (x > width || y > height || x < 0 || y < 0) {
    isAlive = false;
  }
  println(smoothedData[0]);
}