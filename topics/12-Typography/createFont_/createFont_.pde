// prefer createFont ( vector fonts TTF/OTF) over loadFont (VLW)!
// !!! write code to view all the fonts!


// list fonts available on system
String[] fontList = PFont.list();
printArray(fontList);  // createFont(name, size)

// example of using font
PFont f;
f = createFont("Serif", 24);
textFont(f);
text("Hello", 10,10);