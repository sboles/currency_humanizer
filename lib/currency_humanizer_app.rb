#!/usr/bin/env ruby

require File.expand_path('../currency_humanizer',  __FILE__)

if ARGV.length != 1
  puts <<DOC
Usage: currency_humanzier_app.rb currency_string
Example: currency_humanzier_app.rb 1234.56
DOC
  exit(0)
end

puts CurrencyHumanizer.humanize(ARGV[0])
