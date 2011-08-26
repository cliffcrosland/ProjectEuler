/* Returns true iff the number is prime. */
function isPrime(n) {
  if (n < 2) return false;
  if (n == 2) return true;
  if (n % 2 == 0) return false;
  for (var i = 3; i * i <= n; i += 2) {
    if (n % i == 0) return false;
  }
  return true;
}
