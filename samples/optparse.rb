#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

options = {
  verbose: false # default value
}

OptionParser.new { |opts|
  opts.banner = <<~EOD
    OptParse examples.
    Usage: #{$PROGRAM_NAME} [args]
    0. This message is a nice multi-line help.
    1. Boolean flag parsing
      Source: https://stackoverflow.com/questions/54576873/ruby-optionparser-short-code-for-boolean-option
      Behavior:
        - ./optparse.rb --verbose    => true
        - ./optparse.rb --verbose no => false
        - ./optparse.rb --no-verbose => false
        - ./optparse.rb -v yes       => true
        - ./optparse.rb              => false (or whatever is default)
  EOD
  opts.on('-v', '--[no-]verbose [FLAG]', TrueClass, 'Run verbosely') { |v|
    options[:verbose] = v.nil? ? true : v
  }
}.parse!

pp options

puts "Run #{$PROGRAM_NAME} --help to see hints" if ARGV.empty?
