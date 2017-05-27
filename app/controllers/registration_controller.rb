class RegistrationController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :"/registrations/new"
    end
  end

  post '/users' do
    user = User.new(params[:user])
    if User.name_available?(params[:user][:username]) && user.save
      session[:user_id] = user.id
      user.populate_default_categories  #adds default categories
      redirect "/summary"
    else
      flash[:message] = "Failed to create new user."
      erb :"/registrations/new"
    end
  end

end
