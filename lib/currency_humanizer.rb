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

end
