class UserController < ApplicationController

  get '/:user/' do
    erb :"users/index"
  end

  get '/signup' do
    erb :"users/new"
  end

  post '/users' do
    user = User.new(username: params[:username], email: params[:email],
      password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect "/#{user.id}/"
    else
      #add flash saying signup failed
      flash[:message] = "Failed to create new user."
      redirect "/signup"
    end
  end

end
