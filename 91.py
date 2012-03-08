def vec_between(ptA, ptB):
    xDim = ptB[0] - ptA[0]
    yDim = ptB[1] - ptA[1]
    return (xDim, yDim)

def dot_product(vecA, vecB):
    return vecA[0]*vecB[0] + vecA[1]*vecB[1]

def main():
    print "Hey. Problem 91. Is sexy."
    count = 0
    size = 51
    for x1 in range(0, size):
        for y1 in range(0, size):
            for x2 in range(0, size):
                for y2 in range(0, size):
                    p0 = (0, 0)
                    p1 = (x1, y1)
                    p2 = (x2, y2)
                    if p1 == p2 or p0 == p1 or p0 == p2:
                        continue
                    v0 = vec_between(p0, p1)
                    v1 = vec_between(p0, p2)
                    v2 = vec_between(p1, p2)
                    dp0 = dot_product(v0, v1)
                    dp1 = dot_product(v1, v2)
                    dp2 = dot_product(v0, v2)
                    if dp0 == 0 or dp1 == 0 or dp2 == 0:
                        count += 1
    print count / 2


main()
