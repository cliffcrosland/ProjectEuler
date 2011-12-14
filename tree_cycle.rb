class Node 
  def initialize(val)
    @val = val
  end 
  def left=(left)
    @left = left
  end 
  def right=(right)
    @right = right
  end 
  def left
    @left
  end 
  def right
    @right
  end 
  def val=(val)
    @val = val
  end 
  def val
    @val
  end
end


def createTree
  n = [nil]
  1.upto(10) do |val|
    n << Node.new(val)
  end
  n[1].left = n[2]
  n[1].right = n[3]

  n[2].left = n[4]
  n[2].right = n[5]

  n[3].left = n[6]
  n[3].right = n[7]

  n[4].left = n[3]  #n[2] # Cycle - references an ancestor
  n[4].right = n[8]

  n[5].left = n[9]
  n[5].right = n[2]
  n[10].right = n[6] # Not cycle - references a non-ancestor up in the tree

  return n[1]
end

def is_ancestor(ancestor, descendant)
  if ancestor == nil or descendant == nil
    return false
  end
  if ancestor.left == descendant or ancestor.right == descendant
    return true
  end
  if is_ancestor(ancestor.left, descendant) or is_ancestor(ancestor.right, descendant)
    return true
  end
  return false
end 

def contains_cycle(tree)
  return false if !tree
  return (rec_contains_cycle(tree, tree.left) or rec_contains_cycle(tree, tree.right))
end

# Returns true if there is a cycle in the tree.
#
# You can detect a cycle in a linked-list by walking through it with a slow cursor (moves
# in steps of 1) and a fast cursor (moves in steps of two).  If they hit, there's a cycle.
#
# The same idea is used here.  
#
# With each recursion, a slow cursor steps over 1 edge, and a fast cursor steps over two 
# edges.  If a slow cursor intersects a fast one, and the node where they intersect has 
# an ancestor-descendant relationship with the node where the fast cursor just came from, 
# then there is a cycle.
#
def rec_contains_cycle(slow, fast_parent)
  return false if !slow or !fast_parent 
  if (slow == fast_parent.left or slow == fast_parent.right)
    return is_ancestor(slow, fast_parent) 
    return true
  end
  if fast_parent.left
    if (rec_contains_cycle(slow.left, fast_parent.left.left) or 
        rec_contains_cycle(slow.left, fast_parent.left.right) or
        rec_contains_cycle(slow.right, fast_parent.left.left) or 
        rec_contains_cycle(slow.right, fast_parent.left.right)) then
       return true
    end
  end
  if fast_parent.right
    if (rec_contains_cycle(slow.left, fast_parent.right.left) or 
        rec_contains_cycle(slow.left, fast_parent.right.right) or
        rec_contains_cycle(slow.right, fast_parent.right.left) or 
        rec_contains_cycle(slow.right, fast_parent.right.right)) then
       return true
    end
  end
  false 
end


def main
  tree = createTree()
  puts contains_cycle(tree)
end

main
