"""
Clifton Crosland
Project Euler 70 - Investimigating Euler's Totient (phi) function
"""
from projecteuler73 import gcd
import sys

NUM_PHI_VALS = 4000

PHI_VALUES = [0] * (NUM_PHI_VALS + 1)
PHI_VALUES[1] = 1
PHI_VALUES[2] = 1

def is_prime(n):
  if n <= 1: return False
  if n == 2: return True
  if n % 2 == 0: return False
  i = 3
  while i * i <= n:
    if n % i == 0: return False
    i += 2
  return True

def get_digits_histogram(n):
  hist = [0] * 10
  while n != 0:
    digit = n % 10
    hist[digit] += 1
    n /= 10
  return hist

def numbers_are_permutations(a, b):
  hist1 = get_digits_histogram(a)
  hist2 = get_digits_histogram(b)
  return hist1 == hist2

def phi(n):
  i = 2
  # Note, if n is prime, phi(n) = n-1
  count = n-1
  while i*i <= n:
    if n % i == 0:
      if gcd(i, n/i) == 1:
        # If m and n are coprime, then phi(mn) == phi(m) * phi(n)
        return PHI_VALUES[i] * PHI_VALUES[n/i]
      else:
        count -= 2 # The two divisors are removed from the count of co-prime ints less than n
    i += 1
  return count

def main():
  min_ratio_so_far = sys.maxint
  best_n = 1
  # Build phi values for n <= approximately sqrt(10**7)
  for n in range(1, NUM_PHI_VALS + 1):
    PHI_VALUES[n] = phi(n)
  for a in range(1, NUM_PHI_VALS + 1):
    for b in range(a + 1, NUM_PHI_VALS + 1):
      n = a*b
      pn = PHI_VALUES[a] * PHI_VALUES[b]
      if a*b <= 10**7 and gcd(a,b) == 1 and numbers_are_permutations(n, pn):
        ratio = float(n) / (pn)
        if ratio < min_ratio_so_far:
          min_ratio_so_far = ratio
          best_n = n
  print "n = %d has the minimal ratio n/phi(n) for n <= 10**7" % (best_n)
  
if __name__ == "__main__":
  main()