require 'http'

# Returns all documents belonging to an account
class GetDocumentDetails
  def initialize(config)
    @config = config
  end

  def call(document_id:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{@config.API_URL}/documents/#{document_id}")
    response.code == 200 ? extract_document_details(response.parse) : nil
  end

  private

  def extract_document_details(document_data)
    configurations = document_data['relationships']['configurations']
    config_files = configurations.map do |config_file|
      { 'id' => config_file['id'] }.merge(config_file['attributes'])
    end

    { 'id' => document_data['id'], 'configurations' => config_files }
      .merge(document_data['attributes'])
      .merge(document_data['relationships'])
      .merge('policies' => document_data['policies'])
  end
end
