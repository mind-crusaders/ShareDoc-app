=begin
@login_route = '/auth/login'
route('auth') do |routing|
    routing.is 'login' do

        #POST /auth/login
        routing.post do
            account = AuthenticateAccount.new(App.config).call(
                username: routing.params['username'],
                password: routing.params['password'])
            
            session[:current_account] = account
            flash[:notice ] = "Welcome back to Edocs #{account['username']}!"
            routing.redirect '/'
        rescue StandardError
            flash[:error] = 'Username and Password do not match'
            routing.redirect '/auth/login'
        end
    end

    routing.on 'logout' do
        #GET /auth/logout
        routing.get do
            session[:current_account] = nil
            routing.redirect @login_route
        end 
=end 

# frozen_string_literal: true

require 'roda'

module Edocument
  # Web controller for Edocument API
  class App < Roda
    route('auth') do |routing| # rubocop:disable Metrics/BlockLength
      @login_route = '/auth/login'
      routing.is 'login' do
        # GET /auth/login
        routing.get do
          view :login
        end

        # POST /auth/login
        routing.post do
          logged_in_account = AuthenticateAccount.new(App.config).call(
            JsonRequestBody.symbolize(routing.params)
          )

          # session[:current_account] = account
          SecureSession.new(session).set(:current_account, logged_in_account)
          flash[:notice] = "Welcome back #{logged_in_account['username']}!"
          routing.redirect '/'
        rescue StandardError
          flash[:error] = 'Username and password did not match our records'
          routing.redirect @login_route
        end
      end

      routing.is 'logout' do
        routing.get do
          # session[:current_account] = nil
          SecureSession.new(session).delete(:current_account)
          routing.redirect @login_route
        end
      end

      @register_route = '/auth/register'
      routing.is 'register' do
        routing.get do
          view :register
        end

        routing.post do
          account_data = JsonRequestBody.symbolize(routing.params)
          CreateAccount.new(App.config).call(account_data)

          flash[:notice] = 'Please login with your new account information'
          routing.redirect '/auth/login'
        rescue StandardError => error
          puts "ERROR CREATING ACCOUNT: #{error.inspect}"
          puts error.backtrace
          flash[:error] = 'Could not create account'
          routing.redirect @register_route
        end
      end
    end
  end
end
