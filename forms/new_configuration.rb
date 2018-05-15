# frozen_string_literal: true

require 'dry-validation'

NewConfiguration = Dry::Validation.Form do
  FILENAME_REGEX = %r{^((?![&\/\\\{\}\|\t]).)*$}
  PATH_REGEX = /^((?![&\{\}\|\t]).)*$/

  configure do
    config.messages_file = File.join(__dir__, 'new_configuration_errors.yml')
  end

  required(:filename).filled(max_size?: 256, format?: FILENAME_REGEX)
  required(:doctype).filled(max_size?: 256, format?: FILENAME_REGEX)
  required(:document).filled
end
