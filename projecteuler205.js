/* -- Project Euler Problem 205 --
 *
 * Peter has nine four-sided (pyramidal) dice, each with faces numbered 
 * 1, 2, 3, 4.
 * Colin has six six-sided (cubic) dice, each with faces numbered 
 * 1, 2, 3, 4, 5, 6.
 *
 * Peter and Colin roll their dice and compare totals: the highest total wins. 
 * The result is a draw if the totals are equal.
 *
 * What is the probability that Pyramidal Pete beats Cubic Colin? 
 * Give your answer rounded to seven decimal places in the form 0.abcdefg
 */

/* Wrapper function. Generates all rolls possible with the specified number of
 * dice whose side values are determined by the diceSides array. Calls the
 * given function on each roll generated. */
function generateAllRolls(numDice, diceSides, func, aux) {
  recurGenerateAllRolls([], numDice, diceSides, func, aux); 
}

/* Recursively generates all rolls possible with the specified number of
 * dice whose side values are determined by the diceSides array. Calls the
 * given function on each roll generated. */
function recurGenerateAllRolls(chosenDice, numDice, diceSides, func, aux) {
  if (chosenDice.length == numDice) {
    func(chosenDice, aux);
  } else {
    for (var i = 0; i < diceSides.length; i++) { 
      chosenDice.push(diceSides[i]);
      recurGenerateAllRolls(chosenDice, numDice, diceSides, func, aux);
      chosenDice.pop();
    }
  }
}

/* Returns the sum of the dice. */
function sumDice(dice) {
  var total = 0;
  for (var i = 0; i < dice.length; i++) {
    total += dice[i];
  }
  return total;
}

/* Adds the sum of the chosen dice to the given prob table. */ 
function addSumToProbTable(chosenDice, probTable) { 
  var sum = sumDice(chosenDice);
  if (probTable[sum] === undefined) {
    probTable[sum] = 1;
  } else {
    probTable[sum] += 1;
  }
}

/* Using probability distribution tables for the rolls for Peter and Colin,
 * calculates that probability that Peter wins a given roll and displays
 * it in an alert window. */
function showProbabilityThatPeterWins() { 
  /* Start timer. Just for fun. */
  var startTime = new Date().getTime();

  /* Generate Peter's probability distribution table.
   * Peter has 9 dice that are 4-sided. Can roll a minumum score of 9
   * and a maxiumum score of 36. */
  var peterProbTable = {minSum: 9, maxSum: 36};
  generateAllRolls(9, [1,2,3,4], addSumToProbTable, peterProbTable); 

  /* Generate Colin's probability distribution table. 
   * Colin has 6 dice that are 6-sided. Can roll a minimum score of 6
   * and a maximum score of 36. */
  var colinProbTable = {minSum: 6, maxSum: 36};
  generateAllRolls(6, [1,2,3,4,5,6], addSumToProbTable, colinProbTable);

  /* For each score in Peter's score table, count the number of games where
   * Peter's score could be higher than Colin's score. */
  var numPeterWins = 0;
  for (var i = peterProbTable.minSum; i <= peterProbTable.maxSum; i++) {
    var numPeterRolls = peterProbTable[i];
    for (var j = colinProbTable.minSum; j < i; j++) {
      numPeterWins += numPeterRolls * colinProbTable[j];
    } 
  }

  /* Output result. */
  var totalPossibleGames = Math.pow(4,9) * Math.pow(6,6); 
  var result = ("Time elapsed: " + 
                (new Date().getTime() - startTime) + " ms\n");
  result += ("Num peter wins: " + numPeterWins + "\n");
  result += ("Num total games: " + totalPossibleGames + "\n");
  result += ("Probability of Peter's win: " + 
             (numPeterWins / totalPossibleGames) + "\n"); 
  alert(result);
}

showProbabilityThatPeterWins();

