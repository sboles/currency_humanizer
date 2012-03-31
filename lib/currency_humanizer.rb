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

end
