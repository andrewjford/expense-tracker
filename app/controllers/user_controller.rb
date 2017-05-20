class UserController < ApplicationController

  get '/:user/' do
    erb :"users/index"
  end

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :"users/new"
    end
  end

  get '/login' do
    if logged_in?
      redirect '/'
    else
      erb :"users/login"
    end
  end

  get '/users/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

  post '/users' do
    user = User.new(params[:user])
    if user.save
      session[:user_id] = user.id
      redirect "/#{user.id}/"
    else
      flash[:message] = "Failed to create new user."
      redirect "/signup"
    end
  end

  post '/users/login' do
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
