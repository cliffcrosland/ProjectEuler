# ProjectEuler - Problem 78
# MEMO = {}
# def memo_key(n_coins, largest_pile):
#     return str(n_coins) + " " + str(largest_pile)
# 
# def num_piles(n_coins):
#     count = 0
#     for i in range(1, n_coins + 1):
#         piles = num_piles_given_largest_pile(n_coins, i)
#         MEMO[(n_coins, i)] = piles % 1000000
#         count += piles
#     return count % 1000000
# 
# def num_piles_given_largest_pile(n_coins, largest_pile):
#     if n_coins == largest_pile:
#         return 1
#     if largest_pile == 1:
#         return 1
#     new_n_coins = n_coins - largest_pile
#     new_largest_pile = largest_pile
#     if new_largest_pile > new_n_coins:
#         new_largest_pile = new_n_coins
#     count = 0
#     for i in range(1, new_largest_pile + 1):
#         count += MEMO[(new_n_coins, i)]
#     return count

MEMO = [1]

def pentagonal(n):
    return n*(3*n - 1) / 2

def generalized_pentagonal(n):
    if n < 0:
        return 0
    if n % 2 == 0:
        return pentagonal(n/2 + 1)
    else:
        return pentagonal(-1*((n-1)/2 + 1))

def partition(n):
    total = 0
    pentagonal_index = 0
    sign = -1
    while True:
        pent = generalized_pentagonal(pentagonal_index)
        if pent > n: 
            break
        if pentagonal_index % 2 == 0:
            sign *= -1
        total += sign * MEMO[n - pent]
        pentagonal_index += 1
    total %= 1000000
    MEMO.append(total)
    return total

def main():
    print "Problem 78"
    n_coins = 1
    while True:
        piles = partition(n_coins)
        if n_coins % 100 == 0:
            print n_coins, " =>", piles
        if piles % 1000000 == 0:
            print "HEYEYEYE"
            print n_coins, " = >", piles
            break
        n_coins += 1

main()

