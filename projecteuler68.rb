# Generates permutations, runs a lambda on each
def rec_permute(pool, chosen, some_lambda)
  if pool.empty?
    some_lambda.call(chosen)
  else
    0.upto(pool.size - 1) do |i|
      new_pool = pool[0...i] + pool[i+1...pool.size] 
      new_chosen = chosen + [pool[i]]
      rec_permute(new_pool, new_chosen, some_lambda)
    end
  end
end

# Generates an array of triples that describes the n-gon
def generate_triples(outside_nodes, inside_nodes)
  triples = []
  # outside_nodes : ABCDE
  # inside_nodes  : abcde
  inside_nodes.push(inside_nodes.first) # inside_nodes becomes abcdea
  # triples is going to be : Aab Bbc Ccd Dde Eea
  0.upto(outside_nodes.size - 1) do |i|
    triple = outside_nodes[i, 1] + inside_nodes[i, 2] 
    triples.push(triple)
  end
  triples
end

# Does each triple have the same sum?
def has_special_property?(triples)
  first_sum = triples.first.reduce(0) { |sum, val| sum += val }
  for triple in triples
    sum = triple.reduce(0) { |sum, val| sum += val }
    return false if sum != first_sum
  end
  true
end

# Index of the smallest value in an array
def min_index(arr)
  min, min_index = arr.first, 0
  arr.each_index do |i|
    if arr[i] < min
      min, min_index = arr[i], i
    end
  end
  min_index 
end

# Rotates an array n times
def rotate!(arr, n)
  n.times do 
    arr.push arr.shift
  end
end

# Converts triples into a number
# i.e. - Aab Bbc Ccd Dde Eea => AabBbcCcdDdeEea
def triples_to_num(triples) 
  str = triples.reduce("") { |str, triple| str += triple.to_s }
  str.to_i
end

max_solution = nil

# Call this on each permutation of the numbers 1..9
f = lambda do |numbers|
  # since the solution has 16-digits, 10 is an outside node
  outside_nodes = [10] + numbers[0...4] 
  inside_nodes = numbers[4...numbers.size]
  triples = generate_triples(outside_nodes, inside_nodes)
  if has_special_property?(triples) 

    puts ""
    triples.each { |t| print "(#{t[0]},#{t[1]},#{t[2]}) " }
    puts ""
    puts "Has special property"

    # Unique 16 digit number needs to start with the minimal outside node
    rotate!(triples, min_index(outside_nodes))

    puts "Rotated triples"
    triples.each { |t| print "(#{t[0]},#{t[1]},#{t[2]}) " }
    puts ""

    solution = triples_to_num(triples) 

    puts "A solution: #{solution}"

    if !max_solution || solution > max_solution
      max_solution = solution

      puts "Updating max_solution to: #{max_solution}"

    end
  end
end

rec_permute([1,2,3,4,5,6,7,8,9], [], f) 
puts ""
puts "GLOBAL MAXIMUM SOLUTION: #{max_solution}"

# I liked this problem a ton.  Translating the graphical n-gon problem into a combinatorial
# problem is the kind of algorithmic work that makes me feel all warm and tingly inside.
#
# The largest bug was actually very small.  I looked for the minimal 16-digit number when I was 
# supposed to look for the maximal.  No need to re-run the program though because each potential 
# solution was printed out along the way.  Fixed the code and re-ran it anyway.
#
# I kind of like printing out potential solutions as we go.  It's kind of like watching a progress
# bar scoot toward 100%.
#
# Fun one. 13 seconds to run. About 1.5 hours to think about and write.
