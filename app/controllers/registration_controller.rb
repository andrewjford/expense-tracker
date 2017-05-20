class RegistrationController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      erb :"registrations/signup"
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

end
