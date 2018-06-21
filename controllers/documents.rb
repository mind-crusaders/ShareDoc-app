# frozen_string_literal: true

require 'roda'

module Edocument
  # Web controller for Edocument API
  class App < Roda
    route('documents') do |routing|
      routing.on do
        # GET /documents/

        routing.on "add" do
          routing.get do 
            if @current_user.logged_in?
       
              #    doc_info = GetDocument.new(App.config)
          #                          .call(@current_user, doc_id)
              # puts "DOC: #{doc_info}"
          #    document = Document.new(doc_info)
  
              view :document_add, locals: {
                current_user: @current_user
              }
            else
              routing.redirect '/auth/login'
            end
          end
        end

        routing.get do 
          if @current_user.logged_in?
     
            #    doc_info = GetDocument.new(App.config)
        #                          .call(@current_user, doc_id)
            # puts "DOC: #{doc_info}"
        #    document = Document.new(doc_info)

            view :document, locals: {
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
