VALUE = {
  "I" => 1,
  "V" => 5,
  "X" => 10,
  "L" => 50,
  "C" => 100,
  "D" => 500,
  "M" => 1000
}

ROMANS = %w[M D C L X V I] 

REPEATS = %w[DCCCC CCCC LXXXX XXXX VIIII IIII]

SUB_PAIRS = { 
  "IIII" => "IV",
  "VIIII" => "IX",
  "XXXX" => "XL",
  "LXXXX" => "XC",
  "CCCC" => "CD",
  "DCCCC" => "CM"
}

# Converts a string of Roman numerals to a decimal number
def roman_to_decimal roman 
  decimal = 0
  i = 0

  while i < roman.size do
    pair = roman[i, 2]

    # Single numeral at the end.
    if pair.size == 1
      decimal += VALUE[pair[0,1]] 
      i += 1

    # Normal pair. 
    elsif VALUE[pair[0,1]] >= VALUE[pair[1,1]] then
      decimal += VALUE[pair[0,1]]
      i += 1

    # Subtractive pair. Treat as one numeral.
    else
      decimal += VALUE[pair[1,1]] - VALUE[pair[0,1]]
      i += 2 
    end
  end
  return decimal
end

# Converts a decimal number to a string of Roman numerals
def decimal_to_roman decimal
  roman = ""
  i = 0

  # Greedily append the highest roman numeral that fits
  while i < ROMANS.size
    numeral = ROMANS[i]
    if VALUE[numeral] <= decimal
      roman += numeral
      decimal -= VALUE[numeral]
    else
      i += 1
    end
  end

  # Find groups of unnecessary repeated numerals, replace with subtractive 
  # pairs.
  for repeat in REPEATS do
    roman = roman.sub(repeat, SUB_PAIRS[repeat])
  end

  return roman
end

# Main. Convert Roman numerals in 'roman.txt' to optimized Roman numerals. 
# Print out the total number of characters saved by optimizing.
def main
  chars_saved = 0
  File.open('roman.txt', 'r') do |file| 

    for line in file 
      original = line.strip
      optimized = decimal_to_roman(roman_to_decimal(original))
      chars_saved += original.size - optimized.size
    end 

  end
  puts chars_saved
end

main 
