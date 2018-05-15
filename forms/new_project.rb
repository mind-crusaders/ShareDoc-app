# frozen_string_literal: true

require 'dry-validation'

NewDocument = Dry::Validation.Form do
  required(:name).filled
  optional(:repo_url).maybe(format?: URI.regexp)

  configure do
    config.messages_file = File.join(__dir__, 'new_document_errors.yml')
  end
end
