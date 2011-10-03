"""
Clifton Crosland
Project Euler 102 - How many triangles in the text file contain the origin?
"""

def cross_product_k_component(p1,p2, q1,q2):
  # Returns the k component of the cross product of the vectors p1p2 and q1q2
  a_i = p2[0] - p1[0]
  a_j = p2[1] - p1[1]
  
  b_i = q2[0] - q1[0]
  b_j = q2[1] - q1[1]
  
  return a_i * b_j - a_j * b_i

def same_side(p1, p2, a, b):
  # Returns true if p1 and p2 are on the same side of the line AB,
  # false otherwise.
  k1 = cross_product_k_component(a,b,a,p1)
  k2 = cross_product_k_component(a,b,a,p2)
  return k1*k2 >= 0

def tri_contains_origin(tri):
  origin = (0,0)
  a, b, c = tri[0], tri[1], tri[2]
  # Return true if
  # Origin is on the same side of AB as C is.
  # Origin is on the same side of BC as A is.
  # Origin is on the same side of AC as B is.
  #
  # Otherwise, return false.
  return same_side(origin, c, a, b) and same_side(origin, a, b, c) and same_side(origin, b, a, c)
      
def get_tris_from_file(filename):
  triangles = []
  f = open(filename, 'r')
  for line in f:
    l = line.split(',')
    x1, y1, x2, y2, x3, y3 = float(l[0]), float(l[1]), float(l[2]), float(l[3]), float(l[4]), float(l[5])
    triangle = [(x1,y1),(x2,y2),(x3,y3)]
    triangles.append(triangle)
  return triangles    

def main():
  count = 0
  triangles = get_tris_from_file("triangles.txt")
  for triangle in triangles:
    if tri_contains_origin(triangle):
      count += 1
  print "Number of triangles that contain origin = %d" % (count)

if __name__ == "__main__":
  main()