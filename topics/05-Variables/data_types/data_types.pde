/* Demonstrate variables and primitive data types
 *
 * author: Spencer Mathews
 * date: 4/2016
 * tags: #variables #datatypes
 */

/* processing's primitive data types, note all are signed */
boolean bool = true;
/* byte: 8-bits, range -128 to 127 */
byte b;
/* char: Unicode letters and symbols, 16-bits, single quotes */
char col;
color c;
/* double: 64-bit floating point, supported but not used by Processing functions */
double d;
/* float: 32-bit floating point, cast to float using (float) syntax 
float f;
/* int: 32-bit (what about on 64-bit architecture?), cast to int using (int) syntax */
int i;
/* long: 64-bit */
long l;

void setup() {
  size(500, 500);
  noLoop();  // use noLoop() when there is no animation
}

void draw() {

}