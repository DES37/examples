  // A collection of fast approximations to several functions, compiled from several sources.
  // * Geomutils library by Karsten Schmidt, http://code.google.com/p/toxiclibs/
  // * Ian Stephenson, http://www.dctsystems.co.uk/Software/power.c

public final class FastFunctions{

  public static final int floor(float x){
    return (x>=0f)?(int)x:(int)x-1; 
  }

  public static final float log2(float i){
    float x= Float.floatToRawIntBits(i);
    x*=1.0f/(1<<23);
    x-=127;
    float y=x-floor(x);
    y=(y-y*y)*0.346607f;
    return x+y;  
  }

  public static final float pow2(float i){
    float x=i-floor(i);
    x=(x-x*x)*0.33971f;
    return Float.intBitsToFloat((int)((i+127-x)*(1<<23))); 
  }

  public static final float pow(float a, float b){
    return pow2(b*log2(a));
  }

  public static final float inverseSqrt(float x) {
    float half = 0.5F * x;
    int i = Float.floatToIntBits(x);
    i = 0x5f375a86 - (i >> 1);
    x = Float.intBitsToFloat(i);
    return x * (1.5F - half * x * x);
  }

  public static final float sqrt(float x) {
    return 1f/inverseSqrt(x);
  }

}