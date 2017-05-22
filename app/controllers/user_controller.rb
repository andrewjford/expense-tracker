class UserController < ApplicationController

  get '/:user/' do
    @totals = current_user.total_expenses_by_category(Time.now.month)
    erb :"users/home"
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
      @user = User.find_by(id:params[:user])
      erb :"users/profile"
    else
      redirect '/'
    end
  end

  get '/users/:user/edit' do
    @user = current_user
    erb :"users/edit"
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
