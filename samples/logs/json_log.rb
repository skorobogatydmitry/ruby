# frozen_string_literal: true

require 'json'
require 'logger'

LOGGER = Logger.new $stderr
BASE_DIR = File.expand_path "#{File.dirname(__FILE__)}/.."

LOGGER.formatter = lambda { |severity, datetime, _progname, msg|
  current_file = caller_locations.delete_if { |e| e.path.end_with? File.basename __FILE__ }.first
  JSON.dump(
    {
      severity: severity,
      path: current_file.path.delete_prefix(BASE_DIR),
      line: current_file.lineno,
      label: current_file.base_label,
      timestamp: datetime,
      message: msg
    }
  ) + "\n"
}

if File.expand_path(__FILE__).eql? File.expand_path($PROGRAM_NAME)
  LOGGER.info 'it is a sample log line in JSON'
  LOGGER.warn 'and another line with a different log level'
end
