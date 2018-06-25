# frozen_string_literal: true

require 'roda'

module Edocument
  # Web controller for Edocument API
  class App < Roda
    route('documents') do |routing|
      routing.on do
        routing.is do
          routing.get do
            if @current_user.logged_in?
              view :documents, locals: {
                current_user: @current_user
              }
            else
              routing.redirect '/auth/login'
            end
          end
        end

        routing.is 'add' do
          routing.get do
            if @current_user.logged_in?
              view :document_add, locals: {
                current_user: @current_user
              }
            else
              routing.redirect '/auth/login'
            end
          end
        end

      end
    end
  end
end

