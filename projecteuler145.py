"""
Clifton Crosland
Project Euler 145 - Reversible numbers
"""

def reverse(n):
  result = 0
  while n > 0:
    result *= 10
    result += n % 10
    n /= 10
  return result

def digits_are_odd(n):    
  while n > 0:
    digit = n % 10
    # If any digits are even, return false
    if digit % 2 == 0:
      return False
    n /= 10
  # If all digits are odd, return true
  return True

def number_is_reversible(num_arr):
  num_len = len(num_arr)
  i = 0
  carry = 0
  single_sum = 0
  while i < n_len:
    single_sum = num_arr[i] + num_arr[num_len - 1 - i]

def two_digits_count():
  odds = [1,3,5,7,9]
  evens = [2,4,6,8]
  count = 0
  for o in odds:
    for e in evens:
      if o + e <= 9:
        count += 1
  return count * 2

def three_digits_count():
  odds = [1,3,5,7,9]
  evens = [2,4,6,8]
  count = 0
  for o in odds:
    for e in evens:
      if o + e >= 11:
        count += 1
  return count * 2 * 5 # (The five comes from 0,1,2,3,4 that can be center digit. They won't carry.)

def four_digits_count():
  odds = [1,3,5,7,9]
  evens = [0,2,4,6,8]
  count = 0
  for o1 in odds:
    for o2 in odds:
      for e1 in evens[1:]:
        for e2 in evens:
          if o1 + e1 <= 9 and o2 + e2 <= 9:
            count += 2 # Odd start, even start
  return count * 2 # Backward and forwards

def six_digits_count():
  odds = [1,3,5,7,9]
  evens = [0,2,4,6,8]
  count = 0
  for o1 in odds:
    for o2 in odds:
      for o3 in odds:
        for e1 in evens:
          for e2 in evens:
            for e3 in evens[1:]: # last digit or first digit cannot be 0
              if o1 + e1 <= 9 and o2 + e2 <= 9 and o3 + e3 <= 9:
                count += 4 # Odd start, even start
  return count * 2 # Backward and forwards

def seven_digits_count():
  odds = [1,3,5,7,9]
  evens = [0,2,4,6,8]
  all_nums = range(0,10)
  count = 0
  for o1 in odds:
    for e1 in evens[1:]:
      for d1 in all_nums:
        for d2 in all_nums:
          if o1 + e1 >= 11 and d1 % 2 == d2 % 2 and d1 + d2 <= 9:
            count += 1
  return count * 2 * three_digits_count()

def eight_digits_count():
  odds = [1,3,5,7,9]
  evens = [0,2,4,6,8]
  count = 0
  for o1 in odds:
    for o2 in odds:
      for o3 in odds:
        for o4 in odds:
          for e1 in evens:
            for e2 in evens:
              for e3 in evens:
                for e4 in evens[1:]: # last digit or first digit cannot be 0
                  if o1 + e1 <= 9 and o2 + e2 <= 9 and o3 + e3 <= 9 and o4 + e4 <= 9:
                    count += 8 # Odd start, even start
  return count * 2 # Backward and forwards
  

# Look in the forum for the analytical approach to these puppies.
# Could explain, but I don't care to.
def even_digits_count(n):
  k = n / 2
  return 20 * 30**(k-1)

def odd_digits_count(n):
  if (n - 1) % 4 == 0:
    # If num digits == 4*k + 1 for some k, no solutions since the
    # middle digit must add with itself to produce odd result.
    return 0
  else:
    k = (n - 3) / 4
    # If num digits == 4*k + 3 for some k, the solutions is
    # (5 for the middle digit) * (20 for last and first) * (25 * 20) ** n
    return 100 * (500)**k # Surrounding the center
  

def main():
  # print two_digits_count() \
  #    + three_digits_count() \
  #    + four_digits_count() \
  #    + six_digits_count() \
  #    + seven_digits_count() \
  #    + eight_digits_count()
  count = 0
  for i in range(1, 9):
    if i % 2 == 0:
      count += even_digits_count(i)
    else:
      count += odd_digits_count(i)
  print count

if __name__ == "__main__":
  main()