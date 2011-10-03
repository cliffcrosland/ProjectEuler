"""
Clifton Crosland
Project Euler 82 - Shortest path in a matrix.
"""
def read_matrix_from_file(filename):
  f = open(filename, "r")
  matrix = []
  for line in f:
    line_list = line.split(',')
    for i in range(0, len(line_list)):
      line_list[i] = int(line_list[i])  
    matrix.append(line_list)
  return matrix

def minimum_of_column(matrix, col):
  min_so_far = matrix[0][col]
  for i in range(1, len(matrix)):
    if matrix[i][col] < min_so_far:
      min_so_far = matrix[i][col]
  return min_so_far

def find_shortest_to_right(matrix, row, col):
  start_val = matrix[row][col]
  # Look right
  min_path_so_far = start_val + matrix[row][col+1]
  
  # Scan up
  r = row - 1
  path = start_val
  while r >= 0:
    path += matrix[r][col]
    if path + matrix[r][col+1] < min_path_so_far:
      min_path_so_far = path + matrix[r][col+1]
    r -= 1
    
  # Scan down
  r = row + 1
  path = start_val
  while r < len(matrix):
    path += matrix[r][col]
    if path + matrix[r][col+1] < min_path_so_far:
      min_path_so_far = path + matrix[r][col+1]
    r += 1
  
  # Return shortest path from start cell (row,col) to some
  # cell to the right
  return min_path_so_far

def main():
  matrix = read_matrix_from_file("matrix.txt")
  new_column = [0] * len(matrix) # Our Dynamic Programming column
  curr = len(matrix) - 2 # Start with second to last column in matrix
  while curr >= 0:
    for i in range(0, len(matrix)):
      new_column[i] = find_shortest_to_right(matrix, i, curr)
    for i in range(0, len(matrix)):
      matrix[i][curr] = new_column[i]
    curr -= 1
  print minimum_of_column(matrix, 0)
  

if __name__ == "__main__":
  main()