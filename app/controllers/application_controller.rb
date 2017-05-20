require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "ratsofatso"
    use Rack::Flash
  end

  get '/' do
    erb :welcome
  end

end
