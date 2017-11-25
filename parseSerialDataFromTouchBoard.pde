
// EVALUATES AND PROCESSES DATA SAVED TO 
// serialDataFromTouchBoard

void parseSerialDataFromTouchBoard(String s) {
 // Parses out the two *s that bookend the data, as a way 
 // to make sure the 12 electrode values are available.
 if((s.charAt(0) == '*') && (s.lastIndexOf('*') != 0)) {
 
   //This line of code parses away the *s at the beginning and end of 
   //the string, recasts the string data as int values, and then saves it
   //to the array, arrayOfTouchBoardData
   arrayOfTouchBoardData = int(split(s.substring(1,s.length() - 3), ','));
      
   //This for loop does several things. It loops through the length
   //of the arrayOfTouchBoardData array, which is 12 elements long,
   //and then it saves the values to one of 5 slots in a double array
   //called dataSmoother... more about this in class.
   for(int i = 0; i < arrayOfTouchBoardData.length; i++) {
     if(arrayOfTouchBoardData.length == 12) {
       dataSmoother[i][counter] = arrayOfTouchBoardData[i];
   
       //This println method shows you the smoothed values
       //for each of the electrodes in the console window below.
       println("E" + i + ". " + smoothedData[i]); 
   }

    //Let the smoothing begin! (See the smoothData tab above)
    smoothData();
    
 }
   //This println just adds a line between each set of 12 electrode vals 
   //written to the console below
   println("--------");
 
 }
 
 //The counter is related to the smoothing routine I wrote.
 //More about this in class.
 counter++;
 
 if(counter >=5) {
     counter = 0;
   }
}