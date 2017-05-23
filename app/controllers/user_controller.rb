class UserController < ApplicationController

  get '/summary' do
    if logged_in?
      @totals = current_user.total_expenses_by_category(Time.now.month)
      erb :"users/home"
    else
      redirect '/'
    end
  end

  get '/profile' do
    if logged_in?
      @user = current_user
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
      redirect "/profile"
    elsif params[:new_password] == ""
      flash[:message] = "Please enter a valid password."
      redirect "/users/#{user.id}/edit"
    else
      flash[:message] = "Incorrect Old Password."
      redirect "/users/#{user.id}/edit"
    end
  end

end
