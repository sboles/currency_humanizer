class CurrencyHumanizer

  # Converts a currency string to a human readable English representation of that string
  def self.humanize(currency_string)
    raise "Invalid Format" unless self.valid_currency_string?(currency_string)
  end

  private

  # definition of the regular expression for valid currency strings
  MATCH_PATTERN = /^(\d+)\.(\d\d)$/

  # returns true for valid currency strings, false otherwise
  def self.valid_currency_string?(currency_string)
    return MATCH_PATTERN.match(currency_string)
  end

  # returns the cents fraction
  def self.build_cents_fraction(cents_string)
    return "#{cents_string}/100"
  end

  # returns the cents part of a currency string
  def self.build_cents_part(cents_string)
    return "and #{build_cents_fraction(cents_string)} dollars"
  end

  # returns the last 3 digits of a string representation of a whole number, left padded with 0's
  def self.last_3_digits(number_string)
    return number_string.rjust(3, "0")[-3..-1]
  end

  # Returns human readable English representation of hundredths digit
  def self.hundredths_part(digit)
    if "0".eql?(digit)
      return ""
    else
      return "#{ONES[digit]} hundred"
    end
  end

  # Returns human readable English representation of tenths digit
  def self.tenths_part(digit)
    if "0".eql?(digit)
      return ""
    else
      return TENS[digit]
    end
  end

  # Returns human readable English representation of ones digit
  def self.ones_part(digit)
    if "0".eql?(digit)
      return ""
    else
      return ONES[digit]
    end
  end

  # Returns human readable English representation of tenths_and_ones digit
  def self.tenths_and_ones_part(digits)
    tenths_part = tenths_part(digits[0])
    ones_part = ones_part(digits[1])
    return ones_part if "0".eql?(digits[0])
    return TEENS[digits] if "1".eql?(digits[0])
    return tenths_part if "0".eql?(digits[1])
    return "#{tenths_part}-#{ones_part}"
  end

  ONES = {"0" => "zero",
          "1" => "one",
          "2" => "two",
          "3" => "three",
          "4" => "four",
          "5" => "five",
          "6" => "six",
          "7" => "seven",
          "8" => "eight",
          "9" => "nine"}

  TENS = {"1" => "ten",
          "2" => "twenty",
          "3" => "thirty",
          "4" => "fourty",
          "5" => "fifty",
          "6" => "sixty",
          "7" => "seventy",
          "8" => "eighty",
          "9" => "ninety"}

  TEENS = {"10" => "ten",
           "11" => "eleven",
           "12" => "twelve",
           "13" => "thirteen",
           "14" => "fourteen",
           "15" => "fifteen",
           "16" => "sixteen",
           "17" => "seventeen",
           "18" => "eighteen",
           "19" => "nineteen"}

end
