# frozen_string_literal: true

require 'http'

# Returns all projects belonging to an account
class AddViewerToDocument
  def initialize(config)
    @config = config
  end

  def call(auth_token:, viewer_email:, document_id:)
    config_url = "#{@config.API_URL}/documents/#{document_id}/viewers"

    response = HTTP.accept('application/json')
                   .auth("Bearer #{auth_token}")
                   .post(config_url,
                         json: { email: viewer_email })

    response.code == 201 ? response.parse : nil
  end
end
