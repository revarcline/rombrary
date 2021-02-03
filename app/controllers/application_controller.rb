require './config/environment'

class ApplicationController < Sinatra::Base
  enable :sessions
  use Rack::Flash
  use Rack::MethodOverride
  Dotenv.load
  Dotenv.require_keys('SESSION_SECRET')

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV['SESSION_SECRET']
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end

    def created_by_current?(game)
      game.created_by == current_user
    end
  end
end
