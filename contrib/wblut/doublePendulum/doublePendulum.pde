//http://www.wblut.com/tutorials/processing/double-pendulum/
//http://www.myphysicslab.com/dbl_pendulum.html
 
double gc;
double dt;
double friction;
DoublePendulum pendulum;
 
 
void setup() {
  fullScreen(P3D);
  smooth(8);
  frameRate(30);
  init();
}
 
void init() {
  gc = 9.81;
  dt = 0.0005;
  friction=0.0;
  //center x, center y, length1, length2, mass1, mass2, angle1, angle2, angular velocity1, angular velocity 2, color
  pendulum =new DoublePendulum(width/2, 300, 2, 2, 1.0, 1.0, radians(-170), radians(90), 0.0, 0.0, color(255, 255, 255, 10));
}
 
 
void draw() {
  background(20);
  blendMode(ADD);
  for (int i=0; i<50; i++) {
    pendulum.draw();
    pendulum.update();
  }
  stroke(255,150);
  ellipse(width/2, 300, 10, 10);
}
 
class DoublePendulum {
  double phi1, omega1, phi2, omega2;
  double mass1, mass2;
  double length1, length2;
  float x1, y1, x2, y2;
  float  cx, cy;
  double[] k1, l1, k2, l2;
  color c;
 
  DoublePendulum(float  cx, float  cy, double length1, double length2, double mass1, double mass2, double phi1, double phi2, double omega1, double omega2, color c) {
    this.cx=cx;
    this.cy=cy;
    this.length1=length1;
    this.phi1=phi1;
    this.omega1=omega1;
    this.mass1=mass1;
    k1= new double[4];
    l1= new double[4];
    this.length2=length2;
    this.phi2=phi2;
    this.omega2=omega2;
    this.mass2=mass2;
    k2= new double[4];
    l2= new double[4];
    this.c=c;
  }
 
  double domega1(double phi1, double phi2, double omega1, double omega2) {
    return (-gc*(2*mass1+ mass2)*Math.sin(phi1)-mass2*gc*Math.sin(phi1-2*phi2)-2*Math.sin(phi1-phi2)*mass2*(omega2*omega2*length2+omega1*omega1*length1*Math.cos(phi1-phi2)) )/ (length1*( 2*mass1 + mass2 - mass2*Math.cos(2*phi1-2*phi2)))-friction*omega1;
  }
 
  double domega2(double phi1, double phi2, double omega1, double omega2) {
    return 2*Math.sin(phi1-phi2)*(omega1*omega1*length1*(mass1+mass2)+gc*(mass1+mass2)*Math.cos(phi1)+omega2*omega2*length2*mass2*Math.cos(phi1-phi2))/ (length2*( 2*mass1 + mass2 - mass2*Math.cos(2*phi1-2*phi2)))      -friction*omega2;
  }
 
  void update() {//RK4
    k1[0] = dt*omega1;
    l1[0] = dt*domega1(phi1, phi2, omega1, omega2);
    k1[1] = dt*(omega1+l1[0]/2);
    l1[1] = dt*domega1(phi1+k1[0]/2, phi2, omega1+l1[0]/2, omega2);
    k1[2] = dt*(omega1+l1[1]/2);
    l1[2] = dt*domega1(phi1+k1[1]/2, phi2, omega1+l1[1]/2, omega2);
    k1[3] = dt*(omega1+l1[2]);
    l1[3] = dt*domega1(phi1+k1[2], phi2, omega1+l1[2], omega2);
    k2[0] = dt*omega2;
    l2[0] = dt*domega2(phi1, phi2, omega1, omega2);
    k2[1] = dt*(omega2+l2[0]/2);
    l2[1] = dt*domega2(phi1, phi2+k2[0]/2, omega1, omega2+l2[0]/2);
    k2[2] = dt*(omega2+l2[1]/2);
    l2[2] = dt*domega2(phi1, phi2+k2[1]/2, omega1, omega2+l2[1]/2);
    k2[3] = dt*(omega2+l2[2]);
    l2[3] = dt*domega2(phi1, phi2+k2[2], omega1, omega2+l2[2]);
 
    phi1 = phi1 + (k1[0]+2*k1[1]+2*k1[2]+k1[3])/6;
    omega1 = omega1 + (l1[0]+2*l1[1]+2*l1[2]+l1[3])/6;
    phi2 = phi2 + (k2[0]+2*k2[1]+2*k2[2]+k2[3])/6;
    omega2 = omega2 + (l2[0]+2*l2[1]+2*l2[2]+l2[3])/6;
    x1=(float)(cx+100*length1*Math.sin(phi1));
    y1=(float)(cy+100*length1*Math.cos(phi1));
    x2=(float)(x1+100*length2*Math.sin(phi2));
    y2=(float)(y1+100*length2*Math.cos(phi2));
  }
 
  void draw() {
    stroke(c);
    line(cx, cy, -1, x1, y1, -1);
    line(x1, y1, -1, x2, y2, -1);
    fill(0);
    ellipse(x1, y1, 10, 10);
    ellipse(x2, y2, 10, 10);
  }
}