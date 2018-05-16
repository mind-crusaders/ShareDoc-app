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