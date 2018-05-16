class App<  Roda
    use Rack::Session::Cookie,
        expire_after: ONE_MONTH,
        secret: config.SESSION_SECRET
    
    route do |routing|
        @current_account = session[:current_account]
        #routing begins...
    end