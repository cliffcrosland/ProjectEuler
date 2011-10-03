"""
Clifton Crosland
Project Euler 74 - Exploring factorial chains
"""

# Memoized factorial and chain length calculations.
FACTORIAL = [1,1,2,6,24,120,720,5040,40320,362880]
CHAIN_LENGTHS = [-1] * 3000000
  
  
def factorial_digits_sum(n):
  total = 0
  while n != 0:
    digit = n % 10
    total += FACTORIAL[digit]
    n /= 10
  return total

def chain_length(n):
  orig = n      
  chain_dict = {}
  chain_dict[n] = 1
  while True:
    n = factorial_digits_sum(n)
    # Already memoized.  Grab it.
    if CHAIN_LENGTHS[n] != -1:
      CHAIN_LENGTHS[orig] = len(chain_dict.keys()) + CHAIN_LENGTHS[n]
      return CHAIN_LENGTHS[orig]
    # Not already memoized.  Look to see if its in the current chain.
    if n in chain_dict:
      CHAIN_LENGTHS[orig] = len(chain_dict.keys())
      return CHAIN_LENGTHS[orig]
    chain_dict[n] = 1

def main():
  i = 1
  count = 0
  while i <= 1000000:
    length = chain_length(i)
    if length == 60:
      count += 1
    i += 1
  print count

if __name__ == "__main__":
  main()