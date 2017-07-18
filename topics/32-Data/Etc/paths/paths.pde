/*
 * listPaths() and listFiles() are new functions
 *
 * Relative paths are assumed relative to sketch directory but
 * listPaths() will return absolute paths unless "relative" option given.
 *
 * Other options that work with both:
 *   "recursive", "extension=XX", "directories", "files", "hidden"
 *
 * See https://processing.org/examples/directorylist.html for older manual method
 *
 * pretty complete
 */

void setup() {
  String path;
  path = sketchPath();
  //path = System.getProperty("user.home");

  // list directory contents as Strings
  String[] string = listPaths(path);
  for (String p : string) {
    println(p);
  }
  
  // list directory contents as Files
  File[] files = listFiles(path);
  for (File f : files) {
    println(f.getAbsolutePath());
  }
}