/**
 * @file Utility functions for bijective mapping between integers and integer arrays.
 * @author dobrokot
 * @link https://github.com/dobrokot
 */
#reloadable
#priority 3000

function power(base as int, exp as int) as int {
  if (exp < 0) return 0; // Or throw an error
  if (exp == 0) return 1;
  var res = 1;
  for i in 0 .. exp {
    res *= base;
  }
  return res;
}

/**
 * Assigns a unique index to an array containing the number 1.
 * The mapping is monotonic with respect to the maximum element of the array.
 * @param arr The input array. Must contain the number 1.
 * @return A unique integer index, or -1 if the array does not contain 1.
 */
function array_with_1_to_index(arr as int[]) as int {
  val N = arr.length;
  var m = 0;
  for x in arr {
    if (x > m) m = x;
  }

  if (m == 1) {
    var result = 0;
    for a in arr {
      result = result * 2 + a;
    }
    val final_result = result - 1;
    return final_result;
  }

  val count_less_m = power(m, N) - power(m - 1, N);
  val count_less_or_equal_m = power(m + 1, N) - power(m, N);
  val count_with_m_and_1 = count_less_or_equal_m - count_less_m;

  var result = count_less_m;

  var i as int = arr.indexOf(1);
  var j as int = arr.indexOf(m);

  var swap_addition = 0;
  if (i > j) {
    val temp = i;
    i = j;
    j = temp;
    swap_addition = count_with_m_and_1 / 2;
  }

  result += swap_addition;

  val initial_result_before_ij_loop = result;
  for i_less in 0 .. N {
    for j_less in (i_less + 1) .. N {
      if (i_less > i || (i_less == i && j_less >= j)) {
        break;
      }
      val segment_before = power(m - 1, i_less);
      val segment_between = power(m, j_less - i_less - 1);
      val segment_after = power(m + 1, N - j_less - 1);
      result += segment_before * segment_between * segment_after;
    }
  }

  var number = 0;

  // Segment before i: base (m-1), exclude 1 and m
  for k in 0 .. i {
    var v = arr[k];
    v = v > 1 ? v - 1 : v;
    number = number * (m - 1) + v;
  }

  // Segment between i and j: base m, exclude m
  val intepret_as_1 = swap_addition == 0 ? 1 : m;
  for k in (i + 1) .. j {
    var v = arr[k];
    if (v == intepret_as_1) {
      v = 1;
    }
    number = number * m + v;
  }

  // Segment after j: base (m+1)
  for k in (j + 1) .. N {
    number = number * (m + 1) + arr[k];
  }

  val final_result = result + number;
  return final_result;
}

/**
 * Converts an index back to an array containing the number 1.
 * This is the inverse of array_with_1_to_index.
 * @param index The integer index.
 * @param N The size of the array to generate.
 * @return The corresponding array, or null on error.
 */
function index_to_array_with_1(index as int, N as int) as int[] {
  if (N <= 0) {
    return index == -1 ? [] as int[] : null;
  }

  val binary_count = power(2, N) - 1;

  if (index < binary_count) {
    var binary_index = index + 1;
    val arr = intArrayOf(N);
    for i in 0 .. N {
      arr[i] = binary_index % 2;
      binary_index /= 2;
    }
    arr.reverse();
    return arr;
  }

  var remaining_index = index - binary_count;

  var m = 2;
  while true {
    val count_less_m = power(m, N) - power(m - 1, N);
    val count_less_or_equal_m = power(m + 1, N) - power(m, N);
    val count_with_m_and_1 = count_less_or_equal_m - count_less_m;

    if (remaining_index < count_with_m_and_1) {
      break;
    }
    remaining_index -= count_with_m_and_1;
    m += 1;
  }

  val count_less_m = power(m, N) - power(m - 1, N);
  val count_less_or_equal_m = power(m + 1, N) - power(m, N);
  val count_with_m_and_1 = count_less_or_equal_m - count_less_m;

  val half_count = count_with_m_and_1 / 2;
  val swapped = remaining_index >= half_count;
  if (swapped) {
    remaining_index -= half_count;
  }

  var i = -1;
  var j = -1;
  var found_pair = false;
  for i_loop in 0 .. N {
    for j_loop in (i_loop + 1) .. N {
      val segment_before = power(m - 1, i_loop);
      val segment_between = power(m, j_loop - i_loop - 1);
      val segment_after = power(m + 1, N - j_loop - 1);
      val pair_count = segment_before * segment_between * segment_after;

      if (remaining_index < pair_count) {
        i = i_loop;
        j = j_loop;
        found_pair = true;
        break;
      }
      remaining_index -= pair_count;
    }
    if (found_pair) {
      break;
    }
  }

  if (!found_pair) {
    print(`ERROR: Could not find a valid (i,j) pair for index ${index}`);
    return null;
  }

  val arr = intArrayOf(N, 0);

  if (swapped) {
    arr[i] = m;
    arr[j] = 1;
  }
  else {
    arr[i] = 1;
    arr[j] = m;
  }

  var number = remaining_index;

  // Decode segments in reverse order
  var k = N - 1;
  while k >= j + 1 {
    arr[k] = number % (m + 1);
    number /= m + 1;
    k = k - 1;
  }

  val actual_1_value = swapped ? m : 1;
  k = j - 1;
  while k >= i + 1 {
    val digit = number % m;
    number /= m;
    if (digit == 1) {
      arr[k] = actual_1_value;
    }
    else {
      arr[k] = digit;
    }
    k = k - 1;
  }

  k = i - 1;
  while k >= 0 {
    val digit = number % (m - 1);
    number /= m - 1;
    arr[k] = digit < 1 ? digit : digit + 1;
    k = k - 1;
  }

  return arr;
}
