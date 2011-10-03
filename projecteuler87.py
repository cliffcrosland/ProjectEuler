"""
Clifton Crosland
Project Euler 87 - Prime square, cube, fourth
"""

from projecteuler72 import create_prime_sieve, NOT_VISITED, PRIME, NOT_PRIME

def main():
  numbers_hit_so_far = {}
  prime_sieve = create_prime_sieve(7100)
  primes = [p for p in range(2,len(prime_sieve)) if prime_sieve[p] == PRIME]
  for p1 in primes:
    for p2 in primes:
      for p3 in primes:
        n = p1**2 + p2**3 + p3**4
        if n <= 50000000:
          if n not in numbers_hit_so_far: # DARN DUPLICATES
            numbers_hit_so_far[n] = 1
        else:
          break
  print len(numbers_hit_so_far)

if __name__ == "__main__":
  main()

