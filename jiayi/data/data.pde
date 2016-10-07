int[] heightInfo; //create an array named heightInfo

void setup() {
  size (500, 500);  

  String[] myData=loadStrings("height.csv"); //load data into String named data
  heightInfo = int (split(myData[0], ','));//heightInfo
}

void draw(){
 background (255);
 stroke(0);
 for (int i=0; i<heightInfo.length; i++){ //use for loop to draw bars across.
  rect(i*20, 0, 20, heightInfo[i]); 
 }
  
}