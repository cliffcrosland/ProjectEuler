# ProjectEuler - Problem 78
MEMO = {}
def memo_key(n_coins, largest_pile):
    return str(n_coins) + " " + str(largest_pile)

def num_piles(n_coins):
    count = 0
    for i in range(1, n_coins + 1):
        piles = num_piles_given_largest_pile(n_coins, i)
        MEMO[(n_coins, i)] = piles % 1000000
        count += piles
    return count % 1000000

def num_piles_given_largest_pile(n_coins, largest_pile):
    if n_coins == largest_pile:
        return 1
    if largest_pile == 1:
        return 1
    new_n_coins = n_coins - largest_pile
    new_largest_pile = largest_pile
    if new_largest_pile > new_n_coins:
        new_largest_pile = new_n_coins
    count = 0
    for i in range(1, new_largest_pile + 1):
        count += MEMO[(new_n_coins, i)]
    return count

def main():
    print "Problem 78"
    n_coins = 1
    while True:
        piles = num_piles(n_coins)
        if n_coins % 10 == 0:
            print n_coins, " =>", piles
        if piles == 0:
            print "HEYEYEYE"
            print n_coins, " = >", piles
            break
        # print n_coins, " = >", piles
        n_coins += 1

main()

