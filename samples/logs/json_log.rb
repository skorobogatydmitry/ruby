# frozen_string_literal: true

require 'json'
require 'logger'

LOGGER = Logger.new $stderr
BASE_DIR = File.expand_path "#{File.dirname(__FILE__)}/." # a top project's directory

LOGGER.formatter = lambda { |severity, datetime, _progname, msg|
  current_file = caller_locations.keep_if { |e| File.expand_path(e.path).include? BASE_DIR }.first
  # rubocop:disable Style/StringConcatenation
  JSON.dump(
    {
      severity: severity,
      path: File.expand_path(current_file.path).delete_prefix("#{BASE_DIR}/"),
      line: current_file.lineno,
      label: current_file.base_label,
      timestamp: datetime,
      message: msg
    }
  ) + "\n"
  # rubocop:enable Style/StringConcatenation
}

if File.expand_path(__FILE__).eql? File.expand_path($PROGRAM_NAME)
  LOGGER.info 'it is a sample log line in JSON'
  LOGGER.warn 'and another line with a different log level'
end
