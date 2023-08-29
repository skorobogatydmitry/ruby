# frozen_string_literal: true

require 'yaml'

puts 'Parse an array of objects with dotted-notation paths to a hash tree'

a_list = YAML.safe_load File.read File.join File.dirname(__FILE__), 'sample.yaml'

a_tree = {}

a_list.each { |entry|
  leaf = entry.collect { |k, v|
    next if k.eql? 'path'

    [k, v]
  }.compact.to_h

  entry.transform_keys!(&:to_sym)
  entry[:path]&.split('.')&.inject(a_tree) { |result, path_chunk|
    result[path_chunk.to_sym] ||= entry[:path].split('.').last == path_chunk ? leaf : {}
  }
}

puts 'Result:'
puts YAML.dump a_tree
