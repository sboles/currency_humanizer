require 'helper'

class TestCurrencyHumanizer < Test::Unit::TestCase

  def test_invalid_currencies
    assert !CurrencyHumanizer.valid_currency_string?("")
    assert !CurrencyHumanizer.valid_currency_string?("a")
    assert !CurrencyHumanizer.valid_currency_string?(".")
    assert !CurrencyHumanizer.valid_currency_string?(".0")
    assert !CurrencyHumanizer.valid_currency_string?(".1")
    assert !CurrencyHumanizer.valid_currency_string?("1.")
    assert !CurrencyHumanizer.valid_currency_string?("1.0")
    assert !CurrencyHumanizer.valid_currency_string?("0.0")
    assert !CurrencyHumanizer.valid_currency_string?("0.1")
    assert !CurrencyHumanizer.valid_currency_string?("$0.01")
    assert !CurrencyHumanizer.valid_currency_string?("$0")
    assert !CurrencyHumanizer.valid_currency_string?("1,000.00")
  end

  def test_valid_currencies
    assert CurrencyHumanizer.valid_currency_string?("0.00")
    assert CurrencyHumanizer.valid_currency_string?("1.00")
    assert CurrencyHumanizer.valid_currency_string?("1.01")
    assert CurrencyHumanizer.valid_currency_string?("123.99")
    assert CurrencyHumanizer.valid_currency_string?("1234.99")
    assert CurrencyHumanizer.valid_currency_string?("1234567.99")
    assert CurrencyHumanizer.valid_currency_string?("00000000.99")
    assert CurrencyHumanizer.valid_currency_string?("01928740981273049812093847012981029870.01")
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

end
