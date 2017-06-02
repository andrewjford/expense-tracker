class SessionController < ApplicationController

  get '/' do
    if logged_in?
      redirect "/summary"
    else
      erb :"/sessions/welcome"
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
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/summary"
    else
      flash[:message] = "Incorrect username or password."
      erb :"/sessions/login"
    end
  end

end
