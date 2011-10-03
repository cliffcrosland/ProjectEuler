"""
Clifton Crosland
Project Euler 85 - How many rectangles fit in the grid?
"""
import sys

TARGET = 2000000

def num_rects_in_grid(rows, cols):
  # A grid with r rows and c cols has r+1 horizontal lines and c+1 vertical lines.
  # A rectangle in the grid is defined by choosing 2 horizontal lines and 2 vertical
  # lines.  There are thus r+1 choose 2 times c+1 choose 2 ways to choose the 
  # lines defining a rectangle, which is equal to the number of rectangles in the grid.
  #
  # r+1 choose 2 == (r+1)*r/2
  # c+1 choose 2 == (c+1)*c/2
  return (rows+1)*rows*(cols+1)*cols/4

def main():
  min_dist = sys.maxint
  best_area_so_far = 0
  for rows in range(1, 100):
    for cols in range(1, 100):
      num_rects = num_rects_in_grid(rows, cols)
      dist = abs(TARGET - num_rects)
      if min_dist == -1 or dist < min_dist:
        min_dist = dist
        best_area_so_far = rows * cols
  print "Best area = %d, proximity to 2 million = %d" % (best_area_so_far, min_dist)

if __name__ == "__main__":
  main()