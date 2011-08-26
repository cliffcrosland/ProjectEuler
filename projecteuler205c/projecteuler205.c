#include <stdio.h> 

// NOTE: THIS IS FREAKING SLOW. IF YOU REWRITE IT, DO IT WITH PROBABILITY 
// DISTRIBUTION TABLES. HECK, THE JS VERSION YOU WROTE IS ORDERS OF 
// MAGNITUDES FASTER.

/* Holds data about the number of dice to roll for a given player and what
 * the dice look like. */
struct dice_obj {
  int num_dice;             /* Number of dice to roll */
  int num_die_sides;        /* Number of sides on each die. */
  int *die_sides;           /* The face values on each die (Array). */
  int *chosen_dice;         /* The recursively chosen die rolls (Array). */
};

struct count_obj {
  long long win_count;           /* A pointer to Peter's wins count. */
  struct dice_obj *peter_dice;    /* A pointer to Peter's dice. */
};

/* Definition of function to call on a fully chosen roll of dice. */ 
typedef void roll_func(struct dice_obj *, void *);

/* Recursively generates all rolls possible with the specified dice.
 * Calls the given function on each roll generated. */
static void recur_generate_all_rolls(struct dice_obj *dice, 
                                     int num_chosen_so_far, 
                                     roll_func *func, void *aux)
{
  if (num_chosen_so_far == dice->num_dice) {
    func(dice, aux);
  } else {
    int i;
    for (i = 0; i < dice->num_die_sides; i++) {
      dice->chosen_dice[num_chosen_so_far] = dice->die_sides[i];
      recur_generate_all_rolls(dice, num_chosen_so_far + 1, func, aux);
    }
  }
}

/* Wrapper function. Generates all rolls possible with the specified dice.
 * Calls the given function on each roll generated. */
static void generate_all_rolls(struct dice_obj *dice, roll_func *func, 
                               void *aux) 
{
  recur_generate_all_rolls(dice, 0, func, aux); 
} 

/* Prints the dice, and increments the count. */
static void print_dice(struct dice_obj *dice, void *count_ptr_)
{
  int i;
  long long *count_ptr = (long long *) count_ptr_;
  for (i = 0; i < dice->num_dice - 1; i++) {
    printf("%d,", dice->chosen_dice[i]);
  }
  printf("%d\n", dice->chosen_dice[i]);
  if (count_ptr != NULL)
    ++*count_ptr;
}

/* Returns the sum of the chosen dice. */
static int sum_dice(struct dice_obj *dice)
{
  int sum = 0;
  int i;
  for (i = 0; i < dice->num_dice; i++)
    sum += dice->chosen_dice[i];
  return sum; 
}

/* Compare's colin's dice with Peter's, and increment Peter's win counter
 * if Peter wins. */
static void increment_peter_win(struct dice_obj *colin_dice, void *count_obj_)
{
  struct count_obj *count_obj = count_obj_;

  int colin_sum = sum_dice (colin_dice);
  int peter_sum = sum_dice (count_obj->peter_dice);

  if (peter_sum > colin_sum)
    count_obj->win_count++; 
}

/* Generates Colin's rolls, and calls increment_peter_win on each of Colin's
 * rolls to compare them with Peter's. */ 
static void generate_colin_rolls(struct dice_obj *peter_dice, void *count_obj_)
{
  struct count_obj *count_obj = count_obj_;
  count_obj->peter_dice = peter_dice;

  /* Colin rolls 6 dice. Each die has 6 sides. */
  int chosen_dice[6];
  int die_sides[6] = {1,2,3,4,5,6};

  /* Colin's dice object. */
  struct dice_obj colin_dice;
  colin_dice.num_dice = 6;
  colin_dice.die_sides = die_sides;
  colin_dice.num_die_sides = 6;
  colin_dice.chosen_dice = chosen_dice;

  generate_all_rolls (&colin_dice, increment_peter_win, count_obj); 
}

int main() 
{
  /* Peter's win count. */
  struct count_obj count_obj;
  count_obj.win_count = 0;
  count_obj.peter_dice = NULL;

  /* Peter rolls 9 dice. Each die has 4 sides. */
  int chosen_dice[9];
  int die_sides[4] = {1, 2, 3, 4};

  /* Peter's dice object. */
  struct dice_obj dice;
  dice.num_dice = 9;
  dice.die_sides = die_sides;
  dice.num_die_sides = 4;
  dice.chosen_dice = chosen_dice;

  generate_all_rolls (&dice, generate_colin_rolls, &count_obj);

  printf("Peter win count: %lld\n", count_obj.win_count); 
}
