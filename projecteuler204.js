// WORK IN PROGRESS.  NOT SOLVED YET.

/* -- ProjectEuler Problem 204 --
 * A Hamming number is a positive number which has no prime factor larger 
 * than 5.
 *
 * So the first few Hamming numbers are 1, 2, 3, 4, 5, 6, 8, 9, 10, 12, 15.
 * There are 1105 Hamming numbers not exceeding 10^8.
 *
 * We will call a positive number a generalised Hamming number of type n, if it 
 * has no prime factor larger than n.
 * Hence the Hamming numbers are the generalised Hamming numbers of type 5.
 *
 * How many generalised Hamming numbers of type 100 are there which don't 
 * exceed 10^9?
 */

/* Assumes that 'isprime.js' is already imported. */

/* Returns an array of primes n the range [lowest, highest], inclusive. */
function createPrimesBetween(lowest, highest) {
  var primes = [];
  for (var i = lowest; i <= highest; i++) {
    if (isPrime(i))
      primes.push(i);
  }
  return primes;
}

/* Returns true iff num is not divisible by any of the given primes. */
function isHamming(num, primes) {
  for (var i = 0; i < primes.length; i++) {
    if (primes[i] > num) break;
    if (num % primes[i] == 0) return false;
  }
  return true;
}

/* Prints out the number of Hamming numbers of type 100 that do not 
 * exceed 10^9. */
function projectEuler204() {
  var count = 0;
  var primes = createPrimesBetween(6, Math.pow(10,4));
  console.log(primes);
  var largest = 100; //Math.pow(10,8);
  var avg = 0;
  for (var n = 1; n <= largest; n++) {
    if (isHamming(n, primes)) {
      console.log(n)
      count++; 
    }
  }
  alert("Hamming count = " + count);
}

projectEuler204();
