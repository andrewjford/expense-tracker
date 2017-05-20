class SessionController < ApplicationController
  get '/' do
    if logged_in?
      redirect "/#{current_user.id}/"
    else
      erb :welcome
    end
  end

  get '/login' do
    if logged_in?
      redirect '/'
    else
      erb :"sessions/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/#{user.id}/"
    else
      flash[:message] = "Login failed."
      redirect "/login"
    end
  end

end
