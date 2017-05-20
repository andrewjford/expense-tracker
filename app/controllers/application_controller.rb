require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "ratsofatso"
    use Rack::Flash
  end

  get '/' do
    if logged_in?
      redirect "/#{current_user.id}/"
    else
      erb :welcome
    end
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end

end
