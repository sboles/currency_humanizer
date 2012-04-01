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
    assert_equal "", CurrencyHumanizer.hundredths_part("0"), "0 should return ''"
    assert_equal "one hundred", CurrencyHumanizer.hundredths_part("1"), "1 should return 'one hundred'"
    assert_equal "two hundred", CurrencyHumanizer.hundredths_part("2"), "2 should return 'two hundred'"
    assert_equal "three hundred", CurrencyHumanizer.hundredths_part("3"), "3 should return 'three hundred'"
    assert_equal "four hundred", CurrencyHumanizer.hundredths_part("4"), "4 should return 'four hundred'"
    assert_equal "five hundred", CurrencyHumanizer.hundredths_part("5"), "5 should return 'five hundred'"
    assert_equal "six hundred", CurrencyHumanizer.hundredths_part("6"), "6 should return 'six hundred'"
    assert_equal "seven hundred", CurrencyHumanizer.hundredths_part("7"), "7 should return 'seven hundred'"
    assert_equal "eight hundred", CurrencyHumanizer.hundredths_part("8"), "8 should return 'eight hundred'"
    assert_equal "nine hundred", CurrencyHumanizer.hundredths_part("9"), "9 should return 'nine hundred'"
  end

  def test_tenths_part
    assert_equal "",        CurrencyHumanizer.tenths_part("0")
    assert_equal "ten",     CurrencyHumanizer.tenths_part("1"), "1 should return 'ten'"
    assert_equal "twenty",  CurrencyHumanizer.tenths_part("2"), "2 should return 'twenty'"
    assert_equal "thirty",  CurrencyHumanizer.tenths_part("3"), "3 should return 'thirty'"
    assert_equal "fourty",  CurrencyHumanizer.tenths_part("4"), "4 should return 'fourty'"
    assert_equal "fifty",   CurrencyHumanizer.tenths_part("5"), "5 should return 'fifty'"
    assert_equal "sixty",   CurrencyHumanizer.tenths_part("6"), "6 should return 'sixty'"
    assert_equal "seventy", CurrencyHumanizer.tenths_part("7"), "7 should return 'seventy'"
    assert_equal "eighty",  CurrencyHumanizer.tenths_part("8"), "8 should return 'eighty'"
    assert_equal "ninety",  CurrencyHumanizer.tenths_part("9"), "9 should return 'ninety'"
  end

end
