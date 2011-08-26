def is_prime(n)
  return false if n < 2
  return true if n == 2
  return false if n % 2 == 0
  i = 3
  while i*i <= n
    return false if n % i == 0
    i += 2
  end
  true
end

def generate_primes_less_than(upper_bound)
  primes = []
  (2...upper_bound).each do |n|
    primes.push(n) if is_prime(n)
  end
  primes
end

def rec_add_primes(sum, sums, prime_idx, primes, limit)
  if prime_idx == primes.size
    sums[sum] ||= 0 # initialize to 0 if new
    sums[sum] += 1
  else
    prime = primes[prime_idx]
    while sum <= limit
      rec_add_primes(sum, sums, prime_idx + 1, primes, limit)
      sum += prime
    end
  end
end


def main
  primes = generate_primes_less_than(100)
  sums = {}
  limit = 80 # arrived at just by running experiments
  rec_add_primes(0, sums, 0, primes, limit) 
  
  solution = nil
  sums.keys.sort.each do |sum|
    puts "sums[#{sum}] = #{sums[sum]}"
    if !solution and sums[sum] > 5000
      solution = sum
    end
  end

  puts "Solution : #{solution}"
end

main

# This problem was interesting.  The solution was a LOT smaller than I was
# expecting.  
#
# The algorithm is SUPER close to that used in problem 204.
#
# Basically, the algorithm generates sums of the form 
# 2*i + 3*j + 5*k + ... + 89*x + 97*y.  Could be done using 25 nested for
# loops, but used recursion instead.  (It was a guess that we could find
# the answer just by making sums with the primes less than 100). If the
# sum is bigger than the limit (the limit value was another guess), then
# don't continue.  Otherwise, if we have chosen a coefficient for all the 
# primes (coefficients can have a value 0 and up), then we increment the 
# count of ways to make that sum.
#
# Unlike most problems where you can basically prove your solution space
# bounds right off the bat, it took some experimenting before arriving at 
# the right size of the solution space. 
#
# After experimenting a bit, the program showed that the number of ways to 
# write 50 as a sum of primes was 819, and the number of ways to write 60 
# as a sum of primes jumped way up to 2018.  Getting closer.  So, next, 
# tried finding sum counts for all numbers less than 100.  The program froze 
# for too long.  So, next all the numbers less than 80 were tried.  Bam.  In 3 
# seconds, the code showed that 71 can be written as a sum of primes in 5007
# ways.  Whoop, there it is.
