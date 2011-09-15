def r_max(a)
  a * ((a - 1) / 2).floor * 2
end

def main
  sum = 0
  (3..1000).each do |a|
    sum += r_max(a)
  end
  puts sum
end

main

# Erm, analytically, here are some interesting things:
#
# The binomial expansion of the expression
#
#   (a-1)^n + (a+1)^n = f(a, n)
#
# basically becomes the bionomial expansion of 2*(a+1)^n, except that every other
# term is removed.  Thus, when n is even, all of the terms are divisible by a^2 
# except the last, which is 2.  So if n is even, then r = f(a, n) % a^2 = 2.
# So, none of the choices of n that are even will give us r_max.
#
# What's interesting is that the odd choices of n yield a cycle of remainders.  
# Erm, I didn't analytically determine the cycle, but I saw a pattern in the r_maxes:
#
# r_max(3) = 6
# r_max(4) = 8
#
# r_max(5) = 20
# r_max(6) = 24
#
# r_max(7) = 42
# r_max(8) = 48
#
# r_max(9) = 72
# r_max(10) = 80
#
# I'ma guess the answer by saying that
#
# r_max(a) = a * (greatest even number less than a)
# r_max(a) = a * floor((a - 1) / 2) * a
#
# And.... the answer is right.  Now, I want to justify this cycle and r_max analytically.
# Runs in ~21 ms.
#
# Update: Here's what's up. It's worth noting these two things
#
# 1. (a+1)^n == an + 1 (mod a^2)
#
# 2. (a-1)^n == an - 1 (mod a^2)  <== if n is odd
#    (a-1)^n == 1 - an (mod a^2)  <== if n is even
#
# Hence, if n is even, we have
#
# (a+1)^n + (a-1)^n == (an + 1) + (1 - an) (mod a^2)
#                   == 2 (mod a^2)
#
# And, if n is odd, we have
#
# (a+1)^n + (a-1)^n == (an + 1) + (an - 1) (mod a^2)
#                   == 2an (mod a^2)
#
# So the remainder is either 2 or 2an.  To get r_max, it suffices to choose the 
# largest 2an such that 2an < a^2.  Et, voila.  That is why our r_max choses perfectly.
