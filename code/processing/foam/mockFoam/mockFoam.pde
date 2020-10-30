// Read from the byte file
void setup () {
  // Open a file and read its binary data 
  byte b[] = loadBytes("matrixData"); 
   
  // Print each value, from 0 to 255 
  for (int i = 0; i < b.length; i++) { 
    // Every tenth number, start a new line 
    if (b[i] == 0) { 
      println(); 
    } 
    // bytes are from -128 to 127, this converts to 0 to 255 
    int a = b[i] & 0xff; 
    print(a + " "); 
  } 
  // Print a blank line at the end 
  println(); 
}
