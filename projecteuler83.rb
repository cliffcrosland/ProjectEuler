GRID_DIM = 80

def main
  original = grid_from_file('matrix.txt')

  current_hop = new_grid GRID_DIM, GRID_DIM

  # Base case. 0 hops from destination.
  current_hop[GRID_DIM - 1][GRID_DIM - 1] = original[GRID_DIM - 1][GRID_DIM - 1]

  # Hoppity hop
  min = nil 
  # Erm, I'm not sure when to stop hopping, so I'ma print out min solutions until the hard limit, 80*80 hops
  (GRID_DIM * GRID_DIM).times do 
    if current_hop[0][0] != 0
      if not min or current_hop[0][0] < min
        min = current_hop[0][0]
        puts "#{min} <= best solution so far.  I'ma keep hopping until the hard hop limit (80x80), so Ctrl-C me when you want to stop"
      end
    end
    next_hop = new_grid GRID_DIM, GRID_DIM
    (0...current_hop.size).each do |row|
      (0...current_hop[0].size).each do |col|
        if current_hop[row][col] != 0 # for each current_hop cell with a value 
          [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |step| # for each neighbor of cell
            i, j = step[0], step[1]
            next if i == 0 and j == 0 
            if original[row + i] and original[row + i][col + j] # if not off the board 
              value = current_hop[row][col] + original[row + i][col + j]
              if next_hop[row + i][col + j] == 0 or value < next_hop[row + i][col + j]
                next_hop[row + i][col + j] = value
              end
            end
          end
        end
      end
    end
    current_hop = next_hop
  end

  puts current_hop[0][0]

end

def print_grid grid
  (0...grid.size).each do |row|
    (0...grid[0].size).each do |col|
      print " #{grid[row][col]} "
    end
    print "\n"
  end
  print "\n"
end

def new_grid nrows, ncols
  grid = []
  nrows.times do 
    row = []
    ncols.times do
      row << 0
    end
    grid << row
  end
  grid
end

def grid_from_file filename
  grid = []
  File.open(filename) do |f|
    f.each do |line|
      grid << line.split(',').collect { |num_str| num_str.to_i }
    end
  end
  grid
end

main

# Fun one.  Dynaming programming.
#
# Start from the destination.  Record shortest 0-hop costs (trivial, just the destination cell's cost).  
# Then, record shortest 1-hop path costs.  Then, record shortest 2-hop path costs, and so on.  Eventually
# we'll hippity hop to the origin.  Since the first path to reach the origin need not be the one with least 
# cost, I'ma keep hopping and print out the minimum solutions so far.  Maximum upper bound is definitely 80*80 
# hops, but that takes so long to reach that it's worth it just to Ctrl-C this beast.  Lemme think of a smaller
# upper bound...
