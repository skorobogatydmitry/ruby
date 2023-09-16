# frozen_string_literal: true

# sample function that logs a line
# log is expected to have a correct path relative to the main project dir
def foo
  LOGGER.info 'Log line from the other file than main'
end
