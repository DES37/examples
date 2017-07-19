/* Example of createFont()
 *
 * note: prefer createFont (vector fonts TTF/OTF) over loadFont (VLW)!
 * TODO write code to view all the fonts!
 *
 * author: Spencer Mathews
 */


// list fonts available on system
String[] fontList = PFont.list();
printArray(fontList);  // createFont(name, size)

// example of using font
PFont f;
f = createFont("Serif", 24);
textFont(f);
text("Hello", 10,10);