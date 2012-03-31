require 'helper'

class TestCurrencyHumanizer < Test::Unit::TestCase

  def test_invalid_currencies
    ["", "a", ".", ".0", ".1", "1.", "1.0", "0.0", "0.1", "$0.01", "$0", "1,000.00"].each do |invalid_string|
      assert !CurrencyHumanizer.valid_currency_string?(invalid_string), "#{invalid_string} should be invalid"
    end
  end

  def test_valid_currencies
    ["0.00", "1.00", "1.01", "123.99", "1234.99", "1234567.99", "00000000.99", "01928740981273049812093847012981029870.01"].each do |valid_string|
      assert CurrencyHumanizer.valid_currency_string?(valid_string), "#{valid_string} should be valid"
    end
  end

  def test_humanize_with_invalid_currencies
    assert_raise(RuntimeError) do
      CurrencyHumanizer.humanize("")
    end
  end

  def test_build_cents_fraction
    assert_equal "00/100", CurrencyHumanizer.build_cents_fraction("00")
    assert_equal "99/100", CurrencyHumanizer.build_cents_fraction("99")
  end

  def test_build_cents_part
    assert_equal "and 00/100 dollars", CurrencyHumanizer.build_cents_part("00")
    assert_equal "and 99/100 dollars", CurrencyHumanizer.build_cents_part("99")
  end

  def test_last_3_digits
    ["0", "00", "000", "0000"].each do |currency_string|
      assert_equal "000", CurrencyHumanizer.last_3_digits(currency_string), "last 3 digits of #{currency_string} should be 000"
    end
    ["1", "01", "001", "0001"].each do |currency_string|
      assert_equal "001", CurrencyHumanizer.last_3_digits(currency_string), "last 3 digits of #{currency_string} should be 001"
    end
  end

  def test_hundredths_part
    assert_equal "", CurrencyHumanizer.hundredths_part("0")
    1.upto(9) do |n|
      assert_equal "#{n} hundred", CurrencyHumanizer.hundredths_part(n.to_s), "#{n} should return '#{n} hundred'"
    end
  end

end
