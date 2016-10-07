Boolean amIhappy;

if (day()==5) {
  amIhappy=true;
} else {
  amIhappy=false;
}

if (amIhappy==true) {
  background (255, 0, 0);
} else {
  background (0);
}

//THE FOLLOWING CODE ACHIEVE THE SAME THING, BUT RUNS SLOWER!
//if (day()==5) {

//  background (255, 0, 0);
//} else {
//  background (0);
//}