# frozen_string_literal: true

require 'http'
require 'aws-sdk-s3'

# Returns all projects belonging to an account
class GetDocument
  def initialize(config)
    @config = config
  end

  def call(user, doc_id)
    file = document.output[:profile][:tempfile]

    s3 = Aws::S3::Client.new(
      access_key_id: @config.AWS_ACCESS_KEY_ID,
      secret_access_key: @config.AWS_SECRET_ACCESS_KEY,
      region: @config.AWS_REGION
    )

    object_key = "#{@config.AWS_PROFILE_FOLDER_NAME}/#{user.username}"
    result = s3.put_object(bucket: @config.AWS_BUCKET_NAME, key: object_key, body: file)

    # Setting the object to public-read
    s3.put_object_acl({
      acl: "public-read",
      bucket: @config.AWS_BUCKET_NAME,
      key: object_key
    })
    document_url = "#{@config.AWS_S3_URL}/#{@config.AWS_BUCKET_NAME}/#{object_key}"
    document = {document: document_url}

    response = HTTP.auth("Bearer #{user.auth_token}")
                   .post("#{@config.API_URL}/documents/#{doc_id}",
                    json: profile_json)
    response.code == 200 ? response.parse : nil
    raise InvalidProfile unless response.code == 201

=begin
    response = HTTP.auth("Bearer #{user.auth_token}")
                   .get("#{@config.API_URL}/documents/#{doc_id}")
    response.code == 200 ? response.parse : nil
=end  
  end
end