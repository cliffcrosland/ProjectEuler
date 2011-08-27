def pandigital?(num)
  histogram = [0] * 10 
  while num > 0
    digit = num % 10
    return false if digit == 0
    histogram[digit] += 1
    return false if histogram[digit] > 1
    num /= 10
  end 

  histogram.shift # remove the 0 digit count

  histogram.each do |count|
    return false if count != 1
  end

  true
end

def main
  a_billion = 10**9
  a_bajillion = 10**15
  phi = (1 + Math.sqrt(5)) / 2

  a, b = 1, 1 # Fib(1) = 1, and Fib(2) = 1
  fib_top = 1 # keep the first 15 digits (if less, there are precision problems *frowny face*)
  n = 2 
  while true
    fib_bottom = (a + b) % a_billion # keep the last 9 digits
    a = b
    b = fib_bottom

    # keep the top digits using the closed form:
    # Fib(n) = floor( (phi ^ n) / sqrt(5) + 1/2 )
    fib_top = (fib_top * phi + 0.5).floor 
    fib_top = fib_top.to_s[0,15].to_i if fib_top > a_bajillion

    n += 1 

    if pandigital?(fib_bottom)
      first_nine = fib_top.to_s[0,9].to_i
      if pandigital?(first_nine)
        puts ""
        puts "FREAK OUT!!!"
        puts "Solution is : #{n}"
        puts ""
        puts "last nine digits  : #{fib_bottom}"
        puts "first nine digits : #{first_nine}"
        return
      end
    end

  end 
end

main

# 100th PROBLEM SOLVED!  WOOT!  Level 3.  Count it.
#
# I kind of hated this problem.  I ended up doing a hacky job of determining the first
# 9 digits of fib(n).  Also, I found someone else's solution to the problem online while
# looking for fibonacci number properties, which kind of sucks.  The author of the
# solution I found used the log_10 of Binet's formula, but his implementation made no
# sense (he even calls it a little magic).  I'm sure using Binet and logarithms is the 
# way to go on this, but I'm tired.  I'ma go read the thread on how to really solve this.
#
# Update: After reading the thread, I am happy.  I rewrote the algorithm based on an idea from
# one of the folks. Keep the bottom 9 using addition, and keep the top 9 using multiplication by phi.
# Wham bam.  2 second solution, as opposed to 1 minute.
