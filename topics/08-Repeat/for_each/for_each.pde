/* Illustrate use of "enhanced for loop" (for-each Java 5+)
 *
 * reference: https://processing.org/reference/for.html
 *
 * note: it's not clear that this is actually covered in Reas/Fry
 *
 * author: Spencer Mathews
 * tags: #loops #for
 */

int[] nums = { 5, 4, 3, 2, 1 };

for (int i : nums) {
  println(i);
}