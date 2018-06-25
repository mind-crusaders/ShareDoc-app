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
=begin 
              doc_info = GetDocument.new(App.config)
                                    .call(@current_user, doc_id)
                
              document = Document.new(doc_info)
=end
              view :documents, locals: {
                current_user: @current_user#, document: document
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

