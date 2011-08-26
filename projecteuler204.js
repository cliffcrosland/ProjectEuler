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

Global = { count : 0, hammings : [] };

/* Assumes that 'isprime.js' is already imported. */

/* Returns an array of primes less than the limit. */
function createPrimesLessThan(limit) {
  var primes = [];
  for (var i = 2; i < limit; i++) {
    if (isPrime(i))
      primes.push(i);
  }
  return primes;
}

function recGenerateHammings(hamming, limit, prime_idx, primes) {
  if (prime_idx == primes.length) {
    Global.count++;
    // console.log("hamming #" + Global.count + " : " + hamming);
  } else {
    var prime = primes[prime_idx];
    while (hamming <= limit) {
      recGenerateHammings(hamming, limit, prime_idx + 1, primes);
      hamming *= prime;
    }
  }
}

/* Prints out the number of Hamming numbers of type 100 that do not 
 * exceed 10^9. */
function projectEuler204() {
  var start = new Date().getTime(); 
  var primes = createPrimesLessThan(100); 

  recGenerateHammings(1, Math.pow(10, 9), 0, primes); 

  var elapsed = new Date().getTime() - start;

  alert(Global.count + " \n Took " + elapsed + " ms.");
}

projectEuler204();

// Originally, I solved the problem using traditional Hamming numbers, meaning numbers
// that have no prime factor greater than 5.  Whoops.  Lesson learned: read the problem 
// more carefully.  The problem asked for the number of generalized Hamming numbers of 
// type 100 that do not exceed 10^9.  
//
// This could be done using 25 nested for-loops, one for each of the primes less than
// 100.  That's pretty ludicrous, so I did the equivalent using recursion.  The idea
// is that we loop through powers of each prime creating hamming numbers of the form 
// 2^i * 3^j * 5^k * ... * 89^x * 97^y.  If the hamming gets bigger than the limit, 10^9,
// we don't continue.  If we've gotten through all the primes, and there is some power
// selected for all of them, then our hamming is less than the limit and is fully formed,
// so increment the hamming counter.
//
// Wham bammin. ~500 ms, when run in Chrome's V8.
