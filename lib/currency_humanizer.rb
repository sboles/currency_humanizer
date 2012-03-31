class CurrencyHumanizer

  def self.humanize(currency_string)
    raise "Invalid Format" unless self.valid_currency_string?(currency_string)
  end

  private

  MATCH_PATTERN = /^(\d+)\.(\d\d)$/

  def self.valid_currency_string?(currency_string)
    return MATCH_PATTERN.match(currency_string)
  end

  def self.build_cents_fraction(cents_string)
    return cents_string + "/100"
  end

  def self.build_cents_part(cents_string)
    return "and #{build_cents_fraction(cents_string)} dollars"
  end

  # returns the last 3 digits of a string representation of a whole number, left padded with 0's
  def self.last_3_digits(number_string)
    return number_string.rjust(3, "0")[-3..-1]
  end

end
