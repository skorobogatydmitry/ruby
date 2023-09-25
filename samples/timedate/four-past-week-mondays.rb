#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Use ActiveSupport core to generate last 4 Date objects for Mondays'

require 'active_support'
require 'active_support/core_ext/numeric/time'

puts(4.times.collect { |i| (Date.parse('Monday') - i.weeks).strftime '%b-%d' })
