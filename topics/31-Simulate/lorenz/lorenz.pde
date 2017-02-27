// from http://tableaupicasso.com/lorenz-attractor/

PrintWriter textFile;
 
//set parameters
float h=0.008;
float a=10;
float b=28;
float c=8/3;
 
//set initial conditions
float x=0;
float y=10;
float z=10;
 
 
void setup() {
  //initialize output text file
  textFile = createWriter("txtfiles/points.txt");
  for(int i=0;i<10000;i++) {
    x+=h*a*(y-x);
    y+=h*(x*(b-z)-y);
    z+=h*(x*y-c*z);
    //print output to console (optional)
    println(x + "," + y + "," + z);
    //save output to text file
    textFile.println(x + "," + y + "," + z);
    textFile.flush();
    exit(); 
  }
}  