#!/usr/bin/env ruby
# frozen_string_literal: true

require 'erb'

# rubocop:disable Lint/UselessAssignment

foo = 'picks'
bar = 'home'

puts ERB.new('welcome <%=bar%>, traveler. ERB templates <%=foo%> variables from the main object scope by default.').result

module Constants
  MAIN = 42
end
puts ERB.new('EBR templates also has access to module constants, e.g. <%=Constants::MAIN%>').result

# sample class to illustrate passing variables scope
class AnObject
  @verb = 'narrowed'

  def initialize
    @verb = 'narrowed'
  end

  def interpolate template_string
    ERB.new(template_string).result binding
  end

  def self.interpolate template_string
    ERB.new(template_string).result binding
  end
end

puts
template_string = 'variables scope can be <%=@verb%> by passing <%=self.class%> -s binding'
puts AnObject.new.interpolate template_string
puts AnObject.interpolate template_string

outer_variable = 'some value from the outer scope'
# Module to demonstrate default ERB variables scope
module Namespace
  TEXT = <<~EOT
    inner variables are <%=defined?(inner_variable) ? 'available' : 'unavailable'%>
    and outer variables are <%=defined?(outer_variable) ? 'available' : 'unavailable'%>
  EOT

  def self.template_outer
    puts "\nif evaluate template by default:"
    inner_variable = 'some inner value'
    ERB.new(TEXT).result # it takes outer variables scope, where inner_variable = 'unavailable'
  end

  def self.template_inner
    puts "\nif evaluate template with current scope:"
    inner_variable = 'some inner value'
    ERB.new(TEXT).result binding
  end
end

puts Namespace.template_outer
puts Namespace.template_inner

puts
source_file = 'template.erb'
puts ERB.new(File.read(source_file)).result

# rubocop:enable Lint/UselessAssignment
