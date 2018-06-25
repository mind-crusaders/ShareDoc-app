# frozen_string_literal: true

require 'http'

module Edocument
  # Returns an authenticated user, or nil
  class VerifyRegistration
    class RegistrationVerificationError < StandardError; end

    def initialize(config)
      @config = config
    end

    def call(username:, email:)
      registration_token = SecureMessage.encrypt(username: username, email: email)
      verification_url = "#{@config.APP_URL}/auth/register/#{registration_token}"
      registration_data = {
        username: username,
        email: email,
        verification_url: verification_url
      }
      
      signed_registration = SecureMessage.sign(registration_data)

      response = HTTP.post("#{@config.API_URL}/auth/register",
                           json: signed_registration)

      raise(RegistrationVerificationError) unless response.code == 201
      response.parse
    end
  end
end
