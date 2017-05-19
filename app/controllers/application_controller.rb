require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "ratsofatso"
  end

  get '/' do
    "Welcome to the Machine"
  end

end
