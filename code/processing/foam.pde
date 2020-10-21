import processing.serial.*;
import processing.sound.*;

SinOsc sine;
Serial ser;

int NUM_ROWS = 3;
int NUM_COLS = 3;
int[][] matrix = new int[NUM_COLS][NUM_ROWS];

void setup () {
  size(500, 500, P3D);
  ser = new Serial(this, "/dev/cu.usbmodem145201", 9600); // select this COMx same as to arduino serial monitor port number
  ser.bufferUntil(byte(0));
  for (int row=0; row<NUM_ROWS; row++) {
    for (int col=0; col<NUM_COLS; col++) {
      matrix[col][row] = 0;
    }
  }
      
  fill(255);
  background(0);
}


void draw() {
  //background(0);
  while (ser.available() > 0) {
    byte[] inBuffer = ser.readBytesUntil(byte(0));
    if (inBuffer == null) continue;

    for (int row=0; row<NUM_ROWS; row++) {
      for (int col=0; col<NUM_COLS; col++) {
        int i = row*NUM_ROWS + col;
        if (i >= inBuffer.length) break;
        int inByte = inBuffer[i];
        if (inByte == 0) break;
        matrix[col][row] = inByte;
      }
    }
  }
  printMatrix();
}

void printMatrix() {
  translate(width/NUM_COLS, height/NUM_ROWS);
  rotateX(PI/4);
  scale(0.5);
  background(0);
  for (int row=0; row<NUM_ROWS; row++) {
      for (int col=0; col<NUM_COLS; col++) {
        int val = matrix[col][row];
        //if (val > 50) {
        //  fill(255, 0, 0);
        //}
        //else {
        //  fill(255);
        //}
        //fill(255-val,255-val, 255-val);
        //circle(width*((float)col/NUM_COLS), height*((float)row/NUM_ROWS), (200-val)/2);
        circle(width*((float)col/NUM_COLS), height*((float)row/NUM_ROWS), val);
      }
    }
}
