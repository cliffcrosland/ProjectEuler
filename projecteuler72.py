"""
Clifton Crosland
Project Euler Problem 72 - Reduced fractions with denom <= 1,000,000
"""

NOT_VISITED = 0
PRIME = 1
NOT_PRIME = 2

def gcd(a, b):
  if a < b:
    return gcd(b,a)
  r = a % b
  while r != 0:
    a = b
    b = r
    r = a % b
  return b

def create_prime_sieve(largest_prime):  
  prime_sieve = [NOT_VISITED] * (largest_prime + 1)
  prime_sieve[0], prime_sieve[1] = NOT_PRIME, NOT_PRIME
  for n in range(2, largest_prime + 1):
    # If n not yet visited, then n is prime.
    if prime_sieve[n] == NOT_VISITED:
      prime_sieve[n] = PRIME
    # Cross out multiples of n.
    multiple = n + n
    while multiple <= largest_prime:
      prime_sieve[multiple] = NOT_PRIME
      multiple += n
  return prime_sieve

def combine_factorizations(fact1, fact2):
  result = {}
  for prime_key in fact1:
    result[prime_key] = fact1[prime_key]
  for prime_key in fact2:
    if prime_key in result:
      result[prime_key] += fact2[prime_key]
    else:
      result[prime_key] = fact2[prime_key]
  return result    

def factorize(n, prime_sieve, factorize_table):
  # If prime, then return the trivial factorization
  if prime_sieve[n] == PRIME:
    factorize_table[n] = {n:1}
    return factorize_table[n]
  # Otherwise, return the combination of previously 
  # computed factorizations of divisors
  d = 2
  while d*d <= n:
    if n % d == 0:
      fact1 = factorize_table[d]
      fact2 = factorize_table[n/d]
      factorize_table[n] = combine_factorizations(fact1, fact2)
      break
    d += 1
  return factorize_table[n]

def phi_from_factorization(factorization):
  result = 1
  for prime in factorization:
    exp = factorization[prime]
    result *= (prime-1)*(prime)**(exp-1)
  return result

def phi(n, prime_sieve, factorize_table):
  factorization = factorize(n, prime_sieve, factorize_table)
  return phi_from_factorization(factorization)

def main():
  prime_sieve = create_prime_sieve(1000000)
  factorize_table = [{}] * 1000001
  count = 0
  for denom in range(2, 1000001):
    count += phi(denom, prime_sieve, factorize_table)
  print count
  
if __name__ == "__main__":
  main()