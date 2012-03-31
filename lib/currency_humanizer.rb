class CurrencyHumanizer

  MATCH_PATTERN = /^(\d+)\.(\d\d)$/

  def self.valid_currency_string?(currency_string)
    return MATCH_PATTERN.match(currency_string)
  end

end
