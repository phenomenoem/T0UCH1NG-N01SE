void smoothData() {
  
  int averaging = 0;
  
  for(int i = 0; i < 12; i++) {
    for(int j = 0; j < 5; j++) {
      averaging += dataSmoother[i][j];
    }
    smoothedData[i] = averaging / 5;
    averaging = 0;
  }
}  