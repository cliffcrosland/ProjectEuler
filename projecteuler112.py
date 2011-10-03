"""
Clifton Crosland
Project Euler 112 - Investigate them bouncy numbers
"""

from projecteuler73 import gcd

def digits_are_increasing(n):
  prev = n % 10
  n /= 10
  while n != 0:
    curr = n % 10
    n /= 10
    if not (curr <= prev):
      return False
    prev = curr
  return True

def digits_are_decreasing(n):
  prev = n % 10
  n /= 10
  while n != 0:
    curr = n % 10
    n /= 10
    if not (curr >= prev):
      return False
    prev = curr
  return True

def is_bouncy(n):
  return not (digits_are_increasing(n) or digits_are_decreasing(n))

def we_are_done(count, n):
  numer = 99
  denom = 100
  g = gcd(n, count)
  count /= g
  n /= g
  return count == numer and n == denom

def main():
  count = 0
  n = 1
  while True:
    if is_bouncy(n):
      count += 1
      if we_are_done(count, n):
        print "n = %d, count = %d" % (n, count)
        return
    n += 1

if __name__ == "__main__":
  main()
