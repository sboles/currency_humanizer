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

  def test_cents_part
    assert_equal "00/100", CurrencyHumanizer.cents_part("00")
    assert_equal "99/100", CurrencyHumanizer.cents_part("99")
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

  def test_ones_part
    assert_equal "", CurrencyHumanizer.ones_part("0"), "0 should return ''"
    assert_equal "one", CurrencyHumanizer.ones_part("1"), "1 should return 'one'"
    assert_equal "two", CurrencyHumanizer.ones_part("2"), "2 should return 'two'"
    assert_equal "three", CurrencyHumanizer.ones_part("3"), "3 should return 'three'"
    assert_equal "four", CurrencyHumanizer.ones_part("4"), "4 should return 'four'"
    assert_equal "five", CurrencyHumanizer.ones_part("5"), "5 should return 'five'"
    assert_equal "six", CurrencyHumanizer.ones_part("6"), "6 should return 'six'"
    assert_equal "seven", CurrencyHumanizer.ones_part("7"), "7 should return 'seven'"
    assert_equal "eight", CurrencyHumanizer.ones_part("8"), "8 should return 'eight'"
    assert_equal "nine", CurrencyHumanizer.ones_part("9"), "9 should return 'nine'"
  end

  def test_tenths_and_ones_part
    assert_equal "", CurrencyHumanizer.tenths_and_ones_part("00"), "00 should return ''"
    assert_equal "one", CurrencyHumanizer.tenths_and_ones_part("01"), "01 should return 'one'"
    assert_equal "two", CurrencyHumanizer.tenths_and_ones_part("02"), "02 should return 'two'"
    assert_equal "three", CurrencyHumanizer.tenths_and_ones_part("03"), "03 should return 'three'"
    assert_equal "four", CurrencyHumanizer.tenths_and_ones_part("04"), "04 should return 'four'"
    assert_equal "five", CurrencyHumanizer.tenths_and_ones_part("05"), "05 should return 'five'"
    assert_equal "six", CurrencyHumanizer.tenths_and_ones_part("06"), "06 should return 'six'"
    assert_equal "seven", CurrencyHumanizer.tenths_and_ones_part("07"), "07 should return 'seven'"
    assert_equal "eight", CurrencyHumanizer.tenths_and_ones_part("08"), "08 should return 'eight'"
    assert_equal "nine", CurrencyHumanizer.tenths_and_ones_part("09"), "09 should return 'nine'"
    assert_equal "ten", CurrencyHumanizer.tenths_and_ones_part("10"), "10 should return 'ten'"
    assert_equal "eleven", CurrencyHumanizer.tenths_and_ones_part("11"), "11 should return 'eleven'"
    assert_equal "twelve", CurrencyHumanizer.tenths_and_ones_part("12"), "12 should return 'twelve'"
    assert_equal "thirteen", CurrencyHumanizer.tenths_and_ones_part("13"), "13 should return 'thirteen'"
    assert_equal "fourteen", CurrencyHumanizer.tenths_and_ones_part("14"), "14 should return 'fourteen'"
    assert_equal "fifteen", CurrencyHumanizer.tenths_and_ones_part("15"), "15 should return 'fifteen'"
    assert_equal "sixteen", CurrencyHumanizer.tenths_and_ones_part("16"), "16 should return 'sixteen'"
    assert_equal "seventeen", CurrencyHumanizer.tenths_and_ones_part("17"), "17 should return 'seventeen'"
    assert_equal "eighteen", CurrencyHumanizer.tenths_and_ones_part("18"), "18 should return 'eighteen'"
    assert_equal "nineteen", CurrencyHumanizer.tenths_and_ones_part("19"), "19 should return 'nineteen'"
    assert_equal "twenty", CurrencyHumanizer.tenths_and_ones_part("20"), "20 should return 'twenty'"
    assert_equal "thirty", CurrencyHumanizer.tenths_and_ones_part("30"), "30 should return 'thirty'"
    assert_equal "fourty", CurrencyHumanizer.tenths_and_ones_part("40"), "40 should return 'fourty'"
    assert_equal "fifty", CurrencyHumanizer.tenths_and_ones_part("50"), "50 should return 'fifty'"
    assert_equal "sixty", CurrencyHumanizer.tenths_and_ones_part("60"), "60 should return 'sixty'"
    assert_equal "seventy", CurrencyHumanizer.tenths_and_ones_part("70"), "70 should return 'seventy'"
    assert_equal "eighty", CurrencyHumanizer.tenths_and_ones_part("80"), "80 should return 'eighty'"
    assert_equal "ninety", CurrencyHumanizer.tenths_and_ones_part("90"), "90 should return 'ninety'"
    assert_equal "ninety-one", CurrencyHumanizer.tenths_and_ones_part("91"), "91 should return 'ninety-one'"
    assert_equal "ninety-two", CurrencyHumanizer.tenths_and_ones_part("92"), "92 should return 'ninety-two'"
    assert_equal "ninety-three", CurrencyHumanizer.tenths_and_ones_part("93"), "93 should return 'ninety-three'"
    assert_equal "ninety-four", CurrencyHumanizer.tenths_and_ones_part("94"), "94 should return 'ninety-four'"
    assert_equal "ninety-five", CurrencyHumanizer.tenths_and_ones_part("95"), "95 should return 'ninety-five'"
    assert_equal "ninety-six", CurrencyHumanizer.tenths_and_ones_part("96"), "96 should return 'ninety-six'"
    assert_equal "ninety-seven", CurrencyHumanizer.tenths_and_ones_part("97"), "97 should return 'ninety-seven'"
    assert_equal "ninety-eight", CurrencyHumanizer.tenths_and_ones_part("98"), "98 should return 'ninety-eight'"
    assert_equal "ninety-nine", CurrencyHumanizer.tenths_and_ones_part("99"), "99 should return 'ninety-nine'"
  end

  def test_magnitude_part
    assert_equal "", CurrencyHumanizer.magnitude_part("000", 0), "000 should return ''"
    assert_equal "one", CurrencyHumanizer.magnitude_part("001", 0), "001 should return 'one'"
    assert_equal "one thousand", CurrencyHumanizer.magnitude_part("001", 1), "001 should return 'one thousand'"
    assert_equal "", CurrencyHumanizer.magnitude_part("000", 1), "000 should return ''"
    assert_equal "one hundred thousand", CurrencyHumanizer.magnitude_part("100", 1), "100 should return 'one hundred thousand'"
    assert_equal "one hundred one thousand", CurrencyHumanizer.magnitude_part("101", 1), "101 should return 'one hundred one thousand'"
    assert_equal "one hundred one million", CurrencyHumanizer.magnitude_part("101", 2), "101 should return 'one hundred one million'"
  end

  def test_dollars_part
    assert_equal "zero", CurrencyHumanizer.dollars_part("0"), "0 should return 'zero'"
    assert_equal "one", CurrencyHumanizer.dollars_part("1"), "1 should return 'one'"
    assert_equal "one million one thousand", CurrencyHumanizer.dollars_part("1001000"), "1001000 should return 'one million one thousand'"
    assert_equal "one billion one thousand", CurrencyHumanizer.dollars_part("1000001000"), "1000001000 should return 'one billion one thousand'"
  end

  def test_humanize
    assert_equal "Zero and 00/100 dollars", CurrencyHumanizer.humanize("0.00"), "0.00 should return 'Zero and 00/100 dollars'"
    assert_equal "One and 01/100 dollars", CurrencyHumanizer.humanize("1.01"), "1.01 should return 'One and 01/100 dollars'"
  end

end
