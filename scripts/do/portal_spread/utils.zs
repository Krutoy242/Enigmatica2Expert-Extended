/**
 * @file Math functions to find positions in 3d sphere
 *
 * @author Krutoy242
 * @link https://github.com/Krutoy242
 */

#priority 3000
#reloadable

// Maximum radius of portal. Must be less that 256
// Consume MAX_R³ RAM memory
static MAX_R as int = 64;

// 8 is maximum z_group size in table_sum_of_two_squares_variants for MAX_R=256.
// For MAX_R=64 its 4
static MAX_GROUP_SIZE as int = 4;

// Number of possible mirrors of one point in 3d sphere
static MAX_MIRRORS as int = 16;

// Number of variations of z for same square distance
static MAX_Z_VARIANTS as int = MAX_R + 2;

// Number of indexes in same 2d squared distance
static MAX_DISTANCE_INDEXES as int = MAX_GROUP_SIZE * MAX_Z_VARIANTS * MAX_MIRRORS;

static table_sum_of_two_squares_variants as int[][int][int] = {} as int[][int][int];

// Create cache of points around portal to faster acces
function init() as void {
  for x in 0 .. (MAX_R+1) {
    for y in 0 .. (x+1) {
      val x2_y2 = x*x + y*y;
      if(x2_y2 > MAX_R * MAX_R) continue;

      // Add new map if not exist
      if(isNull(table_sum_of_two_squares_variants[x2_y2])) {
        table_sum_of_two_squares_variants[x2_y2] = {} as int[][int];
      }

      // "push" implementation
      for i in 0 .. MAX_R {
        if(isNull(table_sum_of_two_squares_variants[x2_y2][i])) {
          table_sum_of_two_squares_variants[x2_y2][i] = [x, y] as int[];
          break;
        }
      }
    }
  }
}

static initialized as bool = false;

/*
  Returns [i, x, y, z] where i is next index
*/
function getNextPoint(index as int) as int[] {
  if(!initialized) {
    initialized = true;
    init();
  }

  // Index is integer-packed [ distance_squared_3d, z, group_index, mirror_index ]
  // with dimensions (anything * MAX_Z_VARIANTS * MAX_GROUP_SIZE * MAX_MIRRORS)
  val distance_squared_3d = index / MAX_DISTANCE_INDEXES;

  val distance_index = index % MAX_DISTANCE_INDEXES;
  var z = distance_index / (MAX_GROUP_SIZE * MAX_MIRRORS);
  val group_index = distance_index % (MAX_GROUP_SIZE * MAX_MIRRORS) / MAX_MIRRORS;
  val mirror_index = distance_index % MAX_MIRRORS;

  // --- --- ---

  # Loop back if reached end or max radius
  if (distance_squared_3d > MAX_R*MAX_R)
    return getNextPoint(0);

  // Go to next z point
  if (z*z > distance_squared_3d)
    return getNextPoint((distance_squared_3d + 1) * MAX_DISTANCE_INDEXES);

  val distance_squared_2d = distance_squared_3d - z*z;
  val z_group = table_sum_of_two_squares_variants[distance_squared_2d];

  // Go to next group
  if(isNull(z_group) || isNull(z_group[group_index]))
    return getNextPoint(distance_squared_3d*MAX_DISTANCE_INDEXES + (z+1) * (MAX_GROUP_SIZE * MAX_MIRRORS));

  val xy = z_group[group_index];
  var x = xy[0] as int;
  var y = xy[1] as int;

  val unwatend_reflections_mask =
    1*(x == 0 ? 1 : 0) +
    2*(y == 0 ? 1 : 0) +
    4*(z == 0 ? 1 : 0) +
    8*(x == y ? 1 : 0);

  var next_mirror_index = mirror_index + 1;
  while ((next_mirror_index & unwatend_reflections_mask) != 0)
    next_mirror_index += 1;

  if ((mirror_index    ) % 2 == 1) x = -x;
  if ((mirror_index / 2) % 2 == 1) y = -y;
  if ((mirror_index / 4) % 2 == 1) z = -z;
  if ((mirror_index / 8) % 2 == 1) { val _x as int = x; x = y; y = _x; }

  return [index + next_mirror_index - mirror_index, x, y, z];
}
