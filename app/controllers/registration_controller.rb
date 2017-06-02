class RegistrationController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/'
    else
      @user = User.new
      erb :"/registrations/new"
    end
  end

  post '/users' do
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      @user.populate_default_categories  #adds default categories
      redirect "/summary"
    else
      flash[:message] = "Please try again. "+"#{@user.errors.full_messages.join(', ')}."
      erb :"/registrations/new"
    end
  end

end
