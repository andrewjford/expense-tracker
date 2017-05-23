class UserController < ApplicationController

  get '/summary' do
    redirect '/summary/0'
  end

  get '/summary/:back' do
    if logged_in?
      @prev_month = params[:back].to_i + 1
      @next_month = params[:back].to_i - 1
      @report_date = subtract_months(Time.now,params[:back])
      @totals = current_user.total_expenses_by_category(@report_date.month)
      erb :"users/home"
    else
      redirect '/'
    end
  end

  def subtract_months(datetime,num)
    #takes datetime and number of months to go back
    #returns datetime
    month = datetime.month - num.to_i
    year = datetime.year
    if month <= 0
      month += 12
      year -= 1
    end
    Time.new(year,month,datetime.day)
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
