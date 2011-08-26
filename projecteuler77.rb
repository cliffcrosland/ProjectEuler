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
    #puts "sums[#{sum}] = #{sums[sum]}"
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
# Unlike most problems where you can basically prove your solution space
# bounds right off the bat, it took some experimenting before arriving at 
# the right size of the solution space. 
#
# After experimenting a bit, the program showed that the number of ways to 
# write 50 as a sum of primes was 819, and the number of ways to write 60 
# as a sum of primes jumped way up to 2018.  We're getting closer.  So, next, 
# tried finding sum counts for all numbers less than 100.  The program froze 
# for too long.  So, next all the numbers less than 80 were tried.  Bam.  In 3 
# seconds, the code showed that 71 can be written as a sum of primes in 5007
# ways.  Whoop, there it is!
