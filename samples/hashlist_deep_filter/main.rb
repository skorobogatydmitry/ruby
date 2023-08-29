puts 'Select the object in-depth'

require 'yaml'

# SAMPLE_SELECTOR = 'cluster.name,apps.metadata.name,apps.spec.resources.required.mem'.freeze
SAMPLE_SELECTOR = 'apps.spec'.freeze
# SAMPLE_SELECTOR = ''

puts "Using '#{SAMPLE_SELECTOR}' selector"

# selector is a dot-separated strings of comma-separated elements
# each part is an expected to be a key in the result's structure
# method parses selector and call a recursive parser
def deep_select data, selectors
  selectors_tree = {}
  selectors&.split(',')&.each { |selector|
    selector&.split('.')&.inject(selectors_tree) { |res, field| res[field] ||= {} }
  }
  dive_in_selection data, selectors_tree
end

# returns dissect of an object by selector
# obj - an object to dissect
# selector - nested tree-like hash where each vertex is a selector
#   on a depth as by its position in the tree
def dive_in_selection obj, selector
  return obj if obj.nil? || selector.empty? # stop non-existent selectors

  case obj
  when Hash
    selector.collect { |k, v|
      [k, dive_in_selection(obj[k], v)]
    }.to_h
  when Array
    obj.collect { |e|
      raise "Non-hash elements in array are not supported, got #{e.class}" unless e.is_a? Hash

      selector.collect { |k, v| [k, dive_in_selection(e[k], v)] }.to_h
    }
  else
    obj
  end
end

source_data = YAML.safe_load File.read File.join(File.dirname(__FILE__), 'sample.yaml')

puts 'Result:'
puts YAML.dump deep_select source_data, SAMPLE_SELECTOR
