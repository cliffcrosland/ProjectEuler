MEMO = {};

function memoKey(nCoins, largestPile) {
  return nCoins + " " + largestPile;
}

function numPiles(nCoins) {
  var count = 0;
  for (var i = 1; i <= nCoins; i++) {
    var piles = numPilesGivenLargestPile(nCoins, i);
    if (MEMO[nCoins] === undefined) MEMO[nCoins] = new Object();
    MEMO[nCoins][i] = piles % 1000000;
    count += piles;
  }
  return count % 1000000;
}

function numPilesGivenLargestPile(nCoins, largestPile) {
  if (nCoins == largestPile) return 1;
  if (largestPile == 1) return 1;
  var newNCoins = nCoins - largestPile;
  var newLargestPile = largestPile;
  if (newLargestPile > newNCoins) newLargestPile = newNCoins;
  var count = 0
  for (var i = 1; i <= newLargestPile; i++) {
    count += MEMO[newNCoins][i];
  }
  return count;
}

function main() {
  console.log("Problem 78");
  var nCoins = 1;
  while (true) {
    var piles = numPiles(nCoins);
    if (nCoins % 10 == 0) {
      console.log(nCoins + " =>" + piles);
    }
    if (piles % 1000000 == 0) {
      console.log("HEYHEYHEYHEY");
      console.log(nCoins + " =>" + piles);
      break;
    }
    nCoins++;
  }
}
