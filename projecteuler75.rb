def gcd(a, b)
  return gcd(b, a) if b > a
  return b if a % b == 0
  return gcd(b, a % b)
end

def coprime?(a, b)
  return gcd(a, b) == 1
end

MAX = 1_500_000

def main
  counts = {}
  (1...MAX).each do |m|
    (1..m).each do |n|
      break if m*n + n*n > MAX
      # m and n generate a primitive pythagorean triple iff
      # m,n are coprime and m - n is odd.
      next if not coprime?(m, n)
      next if (m - n) % 2 != 1
      a = m*m - n*n
      b = 2*m*n
      c = m*m + n*n
      len = a + b + c
      (1..MAX).each do |k|
        break if k*len >= MAX
        counts[k*len] ||= 0
        counts[k*len] += 1
      end
    end
  end

  count = 0
  counts.each_value do |value|
    count += 1 if value == 1
  end 
  puts count
end

main

# A really fun one.  Learned about Euclid's formula for generating primitive 
# Pythagorean triples:
#
# Given positive integers m,n where
#  m > n
#  m and n are coprime
#  m - n is odd
#
# The triple a,b,c with
#  a = m^2 - n^2
#  b = 2mn
#  c = m^2 + n^2
#
# is a primitive pythagorean triple.
#
# The alg is a wee bit slow, but it's not bad.  Runs in ~30 seconds.
