class UserController < ApplicationController

  get '/:user/' do
    erb :"users/index"
  end

  #this path just redirects to actual path with user.id added
  #not sure if this is a good pattern
  get '/users/profile' do
    if logged_in?
      redirect "/users/#{current_user.id}/profile"
    else
      redirect '/'
    end
  end

  get '/users/:user/profile' do
    if logged_in?
      @user = User.find(params[:user])
      erb :"users/profile"
    else
      redirect '/'
    end
  end

  get '/users/:user/edit' do
    @user = current_user
    erb :"users/edit"
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

  patch '/users/:user/edit' do
    user = current_user
    if user.authenticate(params[:old_password]) && params[:new_password] != ""
      user.update(password: params[:new_password])
      redirect "/users/#{user.id}/profile"
    elsif params[:new_password] == ""
      flash[:message] = "Please enter a valid password."
      redirect "/users/#{user.id}/edit"
    else
      flash[:message] = "Incorrect Old Password."
      redirect "/users/#{user.id}/edit"
    end
  end

end
