MAX = 10**8

def palindrome?(num)
  num_str = num.to_s
  len = num_str.length
  (0...len).each do |i|
    return false if num_str[i] != num_str[len - 1 - i]
  end
  return true
end

def main
  # Generate integers less than 10^8 writable as a sum of consecutive squares.
  # Check each for palindrome-ism-ness.
  cool_palindromes_sum = 0
  cool_palindromes_hash = {}
  (2..MAX).each do |num_consecutive|
    # Compute the sum of the squares of the first n integers
    first = 1
    last = num_consecutive
    sum = (first..last).each.reduce { |sum, n| sum += n*n }
    break if sum > MAX

    while sum < MAX
      if palindrome?(sum) and not cool_palindromes_hash[sum]
        cool_palindromes_sum += sum
        cool_palindromes_hash[sum] = true
      end
      # eg. 1*1 + 2*2 + 3*3 ==> 2*2 + 3*3 + 4*4
      sum = sum + (last + 1)**2 - (first)**2
      first += 1
      last += 1
    end
  end
  puts ""
  puts cool_palindromes_sum
end

main

# Luvvved this one.  Not too hard.  The big idea is to choose which order to do the stuff.
# Do we generate all of the palindromes and check each to see if it is the sum of consecutive
# squares?  Or do we go the other way, generate all of the sums of consecutive squares and 
# check each sum to see if it is a palindrome.
#
# Well, that's kind of a no-brainer.  Generating palindromes and sums of squares: Easy.
# Checking if a number is a palindrome: Easy. Checking if a number is a sum of squares: 
# Probably hard.  So, generate the sums of squares and check each for palindrome-ness.
#
# The next big idea is to make sure that you don't count the same palindrome more than 
# once if you generate it a few different ways.  That's what the hash is for.
#
# Takes less than a second.  Count it, chickens!
