class SessionController < ApplicationController
  get '/' do
    if logged_in?
      redirect "/#{current_user.id}/"
    else
      erb :welcome
    end
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

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end

end
