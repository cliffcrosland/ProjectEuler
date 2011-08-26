/* -- ProjectEuler Problem 203 --
 *
 * It can be seen that the first eight rows of Pascal's triangle contain 
 * twelve distinct numbers: 1, 2, 3, 4, 5, 6, 7, 10, 15, 20, 21 and 35.
 *
 * A positive integer n is called squarefree if no square of a prime divides n.
 * Of the twelve distinct numbers in the first eight rows of Pascal's triangle, 
 * all except 4 and 20 are squarefree. The sum of the distinct squarefree 
 * numbers in the first eight rows is 105.
 *
 * Find the sum of the distinct squarefree numbers in the first 51 rows of 
 * Pascal's triangle.
 */

/* Returns the binomial coefficient with arguments n and r, or equivalently
 * returns n Choose r. If the result has already been computed and stored in
 * the memoization map, return it without computing it again. */
function binom(n, r, memoMap) {
  var returnVal;
  var key = (n + "," + r);
  if (memoMap[key] !== undefined)
    return memoMap[key];
  if (r == 0)
    returnVal = 1;
  else if (n == 0)
    returnVal = 0;
  else  
    returnVal = binom(n - 1, r, memoMap) + binom(n - 1, r - 1, memoMap); 
  memoMap[key] = returnVal;
  return returnVal;
}

/* Returns true if the specified number is squarefree. Uses the given 
 * list of primes to check for squarefree-ness. If the list of primes
 * is not complete enough, we add primes to the list. */
function isSquarefree(num, primes) {
  /* If our primes list is not extensive enough, add more primes to it. */
  var lastPrime = primes[primes.length - 1];
  if (lastPrime * lastPrime < num) {
    extendPrimesList(primes, num);
  }
  /* If divisible by a square of a prime, return false. 
   * Otherwise, return true.*/
  for (var i = 0; i < primes.length; i++) {
    var primeSquare = primes[i] * primes[i];
    if (num % (primeSquare) == 0)
      return false;
  }
  return true;
}

/* Returns true iff n is prime. */
function isPrime(n) {
  if (n <= 1) return false; /* If less than 2, not prime. */
  if (n == 2) return true; /* If equal to 2, prime. */
  if (n % 2 == 0) return false; /* If even, and greater than 2, not prime. */
  /* If divisible by some odd number, not prime. */
  for (var i = 3; i * i <= n; i += 2) {
    if (n % i == 0) return false;
  }
  /* If not divisible by any even or odd numbers, prime. */
  return true; 
}

/* Returns the least prime number greater than 'n'. */
function getNextPrimeAfter(n) {
  /* Only check odd values for primality. Cuts work in half. */
  var candidate = (n % 2 == 0) ? (n + 1) : (n + 2);
  while (!isPrime(candidate))
    candidate += 2;
  return candidate;
}

/* Extends the primes list until the square of the last prime is greater
 * than or equal to upperBound. */
function extendPrimesList(primes, upperBound) {
  var p = primes[primes.length - 1];
  while (p * p < upperBound) { 
    p = getNextPrimeAfter(p);
    primes.push(p);
  }
}

/* Calculates the sum of the distinct squarefree numbers in the first 51
 * rows of Pascal's triangle. */
function projectEuler203() {
  /* To memoize the results of calls to binom. Keep a running list of
   * primes as we generate them. */
  var memoMap = {};
  var primes = [2]; // Start with one prime, the integer 2.
  var squarefrees = {};

  var squarefreeSum = 0;
  for (var n = 0; n <= 50; n++) {
    for (var r = 0; r <= n / 2; r++) {
      var binomCoeff = binom(n, r, memoMap);
      if (squarefrees[binomCoeff] === undefined &&
          isSquarefree(binomCoeff, primes)) {
        squarefreeSum += binomCoeff; 
        squarefrees[binomCoeff] = 1;
      }
    }
  } 
  alert("Squarefree sum: " + squarefreeSum);
}

projectEuler203();
