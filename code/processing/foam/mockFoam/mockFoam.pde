int NUM_ROWS = 3;
int NUM_COLS = 3;
int AREA = NUM_ROWS * NUM_COLS + 1;
int index = 0;
int[][] matrix = new int[NUM_COLS][NUM_ROWS];
byte byteFile[];

// Read from the byte file
void setup () {
  // Open a file and read its binary data 
  byteFile = loadBytes("matrixData");
  
  // Set up graphical display
  size(500, 500, P3D);
  
  // Initialize matrix
  for (int row=0; row<NUM_ROWS; row++) {
    for (int col=0; col<NUM_COLS; col++) {
      matrix[col][row] = 0;
    }
  }
  
  fill(255);
  background(0);
}

// Fills a matrix and displays it
void draw() {
  background(0);
  if (index < byteFile.length) {
    // Set matrix
    for (int row=0; row<NUM_ROWS; row++) {
      for (int col=0; col<NUM_COLS; col++) {
        if (index % AREA == 0) {
          index++;
        }
        matrix[col][row] = byteFile[index++];
      }
    }
    
    display();
  }
}

// Renders the byte file graphically
void display() {
  translate(width/NUM_COLS, height/NUM_ROWS);
  rotateX(PI/4);
  scale(0.5);
  textSize(50);
  background(0);
  for (int row=0; row<NUM_ROWS; row++) {
    for (int col=0; col<NUM_COLS; col++) {
      int val = matrix[col][row];
      //text(val, width*((float)col/NUM_COLS), height*((float)row/NUM_ROWS));
      circle(width*((float)col/NUM_COLS), height*((float)row/NUM_ROWS), val);
    }
  }
}

// Prints the byte file contents to the console for debugging
void printFile() {
  // Print each value, from 0 to 255 
  for (int i = 0; i < byteFile.length; i++) { 
    // Every tenth number, start a new line 
    if (byteFile[i] == 0) { 
      println(); 
    } 
    // bytes are from -128 to 127, this converts to 0 to 255 
    int a = byteFile[i] & 0xff; 
    print(a + " "); 
  } 
  // Print a blank line at the end 
  println(); 
}
