MEMO = {};

function memoKey(nCoins, largestPile) {
  return nCoins + " " + largestPile;
}

function numPiles(nCoins) {
  var count = 0;
  for (var i = 1; i <= nCoins / 2; i++) {
    var piles = numPilesGivenSmallestPile(i, nCoins - i);
    count += piles;
  }
  count += 1;
  return count % 1000000;
}

function numPilesGivenSmallestPile(smallestPile, nCoins) {
  if (smallestPile > nCoins) return 0;
  if (smallestPile == nCoins) return 1;
  if (MEMO[nCoins] !== undefined && MEMO[nCoins][smallestPile] !== undefined) {
    return MEMO[nCoins][smallestPile];
  }
  var result = numPilesGivenSmallestPile(smallestPile + 1, nCoins) +
               numPilesGivenSmallestPile(smallestPile, nCoins - smallestPile);
  if (MEMO[nCoins] === undefined) MEMO[nCoins] = new Array();
  MEMO[nCoins][smallestPile] = result % 1000000;
  return result;
}

function main() {
  console.log("Problem 78");
  var nCoins = 1;
  while (true) {
    var piles = numPiles(nCoins);
    if (nCoins % 100 == 0) {
      console.log(nCoins + " => " + piles);
    }
    if (piles % 1000000 == 0) {
      console.log("HEYHEYHEYHEY");
      console.log(nCoins + " => " + piles);
      break;
    }
    nCoins++;
  }
}

if (process)
  main(); // Immediately execute if running from node, which always has a 'process' global object
