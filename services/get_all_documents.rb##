require 'http'

# Returns all projects belonging to an account
class GetAllDocuments
  def initialize(config)
    @config = config
  end

  def call(current_account:, auth_token:)
    response = HTTP.auth("Bearer #{auth_token}")
                   .get("#{@config.API_URL}/accounts/#{current_account['id']}/documents")
    response.code == 200 ? extract_documents(response.parse) : nil
  end

  private

  def extract_documents(documents)
    documents['data'].map do |doc|
      { id: doc['id'],
        filename: doc['attributes']['filname'],
        doctype: doc['attributes']['doctype'] }
    end
  end
end
