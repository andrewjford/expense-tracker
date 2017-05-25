class UserController < ApplicationController

  get '/summary' do
    redirect '/summary/0'
  end

  get '/summary/:back' do
    #:back param represents number of months prior to Time.now
    #used to cycle monthly summaries on view with prev/next links
    if logged_in?
      @prev_month = params[:back].to_i + 1
      @next_month = params[:back].to_i - 1
      @report_date = subtract_months(Time.now,params[:back])
      totals = current_user.get_monthly_totals(@report_date.month)
      @monthly_totals = totals[:hash]      #hash of categories and totals
      @grand_total = totals[:grand_total]  #for grand total at bottom
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
