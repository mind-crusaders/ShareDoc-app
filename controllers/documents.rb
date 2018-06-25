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
        
        routing.on 'add' do
          routing.post do
            document = Form::NewDocument.call(routing.params)
            if profile.failure?
              flash[:error] = Form.message_values(document)
              routing.redirect "/account/#{@current_user.username}"
            end
            AddDocument.new(App.config).call(@current_user,document)
          end
        end

      end
    end
  end
end

