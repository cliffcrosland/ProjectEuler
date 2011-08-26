class Grid
  # Create a new Sudoku grid from an array of 9 strings.
  # Each string is a collection of digits representing a row on the
  # Sudoku board. 0 means space.
  #
  # No error checking FOOOO!  We don't have no errors.
  def initialize(lines) 
    @grid = []
    @histogram = [0] * 10

    0.upto(8) do |row|
      @grid.push([])
      line = lines[row]
      0.upto(line.size - 1) do |i|
        @grid[row].push(line[i,1].to_i)
      end
    end
  end

  # Getter
  def [](row, col)
    return @grid[row][col]
  end

  # Setter
  def []=(row, col, new_value)
    @grid[row][col] = new_value
  end

  AllDigits = [1,2,3,4,5,6,7,8,9].freeze

  # Returns the possible values for the cell
  def cell_possibilities row, col
    # Set subtraction FOOOO! It reeks elegance.
    return (AllDigits - (row_digits(row) + col_digits(col) + square_digits(row, col)))
  end 

  # To string
  def to_s 
    str = ""
    for row in @grid
      for cell in row
        str += " #{cell} "
      end
      str += "\n"
    end
    return str
  end

  private 

  # Returns the digits present in this row
  def row_digits row 
    digits = [] 
    for cell in @grid[row]
      digits.push(cell) if cell != 0
    end 
    return digits 
  end

  # Returns the digits present in this col
  def col_digits col
    digits = [] 
    for row in @grid
      digits.push(row[col]) if row[col] != 0 
    end 
    return digits 
  end

  # Returns the digits present in the cell's 3x3 square
  def square_digits row, col
    digits = [] 
    start_row = (row / 3) * 3
    start_col = (col / 3) * 3 
    start_row.upto(start_row + 2) do |r|
      start_col.upto(start_col + 2) do |c|
        if @grid[r][c] != 0
          digits.push(@grid[r][c])
        end
      end
    end 
    return digits
  end

end

# == Sudoku solvin == 

# Solves the sudoku puzzle. Like a true CEO, delegates this
# shiz to its buddy rec_solve_sudoku, who is legit.
def solve_sudoku grid
  rec_solve_sudoku grid, 0, 0 
end

# Recursively solves the sudoku grid with backtracking.
# Here's how it goes:
# - Look at the board, left-to-right, top-to-bottom.
# - At a blank cell?  Get a list of all of the numbers that haven't already
#   been used in the cell's row, column, and square.
# - Try a number, then recursively keep on truckin and solve the next 
#   cell.  If it fails, that was a bad guess, so try another one.
# - If we run out of possibilities, then we must have made a bad guess 
#   somewhere back where we came from.  So backtrack and fix that shiz.
def rec_solve_sudoku grid, row, col
  # Base case. We've reached beyond the last row, so it's all solved.
  if row > 8
    return true 

  # If the current cell already has a number, solve the next cell.
  elsif grid[row, col] != 0
    return rec_solve_next_cell grid, row, col

  # Try solving the current empty cell
  else 
    possibilities = grid.cell_possibilities row, col

    for guess in possibilities
      grid[row, col] = guess
      # If this guess solves the grid, sweet. Return true.
      if rec_solve_next_cell grid, row, col
        return true
      end 
    end

    # If none of the guesses work, backtrack.
    grid[row, col] = 0
    return false
     
  end
end

# Moves the recursive algorithm on to the appropriate cell
def rec_solve_next_cell grid, row, col
    if col < 8
      return rec_solve_sudoku grid, row, col + 1 # Go to next cell on same row
    else
      return rec_solve_sudoku grid, row + 1, 0 # Go to next row
    end 
end

# Grab sudoku puzzles from 'sudoku.txt'. Solve each of them. Print the sum of 
# the 3-digit numbers found in the top left corner of each solution grid.
def main
  sum = 0
  count = 0
  lines = []

  File.open('sudoku.txt', 'r') do |file| 

    for line in file 
      lines.push(line.strip)
      # Lines that start with the word 'Grid' separate grids.
      if lines.length == 10
        lines.shift() 
        grid = Grid.new(lines) 
        solved = solve_sudoku grid 
        count += 1

        puts (solved ? "Solved Grid #{count}" : "DID NOT SOLVE Grid #{count}") 
        puts grid.to_s 
        puts ""

        # Add 3-digit number in top left corner to the sum
        sum += 100 * grid[0,0] + 10 * grid[0,1] + grid[0,2] 

        lines = [] 
      end
    end 
  end

  puts sum
end

main 

# The biggest performance gains came from decreasing a big constant time
# operation to a smaller one.  Here's the evolution:
#
# 1. At each blank cell, try values 1 through 9.  At every change, check
#    the entire board to make sure that each row, column, and square meets
#    Sudoku constraints.  
# 2. At each blank cell, try values 1 through 9.  At every change, check
#    just the row, column, and square of the change to see if they meet
#    Sudoku constraints. A lot less work than the first approach.
# 3. At each blank cell, try just the values that aren't already in the
#    cell's row, column, and square.  No checking is necessary.
#
# I'm still disappointed that the Ruby implementation takes about 35 seconds 
# to solve the 50 sudoku puzzles given that the Javascript implementation, which
# is more or less identical, takes 2 seconds.  I think Google's V8 engine is
# pretty flipping amazing at reducing the problem to a bunch of fast C++ array
# manipulations.
#
# Update: I just ran the Javascript implementation in Firefox.  It took 26 seconds.
# Google's V8 is super duper impressive in the context of this recursive, array-crunching
# problem. Running the Ruby script is about equivalent to running the problem in JS in Firefox. 
#
# I had a few bugs where I misnamed things, which were a pain to track down.
# For example:
#    for row in @grid
#      digits.push(col) if row[col] != 0 
#    end 
# Should be
#    for row in @grid
#      digits.push(row[col]) if row[col] != 0 
#    end 
#
# Lesson learned: Be very careful when you are writing very similar code multiple times,
# which is what happened in the case above while writing row_digits(), col_digits() and square_digits().
# This is kind of like what John Carmack talks about when he copy-pastes a lot of 3D graphics structs around
# and perpetuates a bug.  Be very thoughtful when copying code.
#
# Also, writing the Javascript implementation in Notepad was cool.  I basically had to keep all of the
# details in my head, whereas here in vim, I have syntax highlighting to guide me around.  That is
# fascinating.  The JS version had just one little bug (forgot to use the "var" keyword once). Granted,
# I did the heavy lifting in this program and just ported over to JS in my mind, so the apparent
# productivity writing the JS in Notepad might be kind of just coinkadink.
#
# Cliff Crosland, Brogrammer
