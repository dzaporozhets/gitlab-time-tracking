APP_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'sinatra/base'
require 'haml'

class GitLabTimeTracking < Sinatra::Base
  set :database_file, "#{APP_ROOT}/config/database.yml"
  set :sessions, true

  require './helpers/render_partial'
  require './lib/network'
  require './models/user'
  require 'sinatra/activerecord'

  get '/' do
    haml :index
  end

  get '/login' do
    haml :login
  end

  get '/logout' do
    sign_out
    redirect '/'
  end

  post '/user_sessions' do
    user = User.authenticate(params[:user_session])

    if user && sign_in(user)
      redirect '/'
    else
      haml :login
    end
  end

  helpers do
    def current_user
      @current_user ||= begin
                          if session[:current_user]
                            Marshal.load(session[:current_user])
                          end
                        end
    end

    def sign_in(user)
      session[:current_user] = Marshal.dump user
    end

    def sign_out
      session[:current_user] = nil
    end

    def authenticate_user!
      unless current_user
        redirect '/login'
        return
      end
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
