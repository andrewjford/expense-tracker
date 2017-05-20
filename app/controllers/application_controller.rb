#require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "ratsofatso"
    use Rack::Flash
  end

  helpers do
    def current_user
      User.find_by(id:session[:user_id])
    end

    def logged_in?
      !!current_user
    end
  end

end
