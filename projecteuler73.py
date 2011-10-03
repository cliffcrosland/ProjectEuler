"""
Clifton Crosland
Project Euler Problem 73 - Exploring reduced fractions
"""

def gcd(a, b):
  if a < b:
    return gcd(b,a)
  r = a % b
  while r != 0:
    a = b
    b = r
    r = a % b
  return b

def main():
  # Fraction structs not actually needed.  Just gcd.
  count = 0
  d = 12000
  while d >= 1:    
    n = int(d/3) + 1
    while 2*n < d:
      if gcd(n,d) == 1:
        count += 1
      n += 1
    d -= 1
  
  print count
  
if __name__ == "__main__":
  main()