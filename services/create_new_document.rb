# frozen_string_literal: true

require 'http'

# Returns all projects belonging to an account
class CreateNewDocument
  def initialize(config)
    @config = config
  end

  def call(auth_token:, new_document:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .post("#{@config.API_URL}/documents",
                         json: new_document)
    new_document = response.parse
    response.code == 201 ? new_document : nil
  end
end
