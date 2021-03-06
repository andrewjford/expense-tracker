class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "ratsofatso"
    use Rack::Flash
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def subtract_months(datetime,num)
      #Used in user_controller's summary page
      #takes datetime and number of months to go back
      #returns datetime
      month = datetime.month - num.to_i
      year = datetime.year
      if month <= 0
        month += 12
        year -= 1
      end
      Time.new(year,month,1)
    end
  end

end
