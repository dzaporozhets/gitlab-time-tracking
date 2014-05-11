APP_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'sinatra/base'
require "sinatra/reloader"
require 'haml'

class GitLabTimeTracking < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  set :database_file, "#{APP_ROOT}/config/database.yml"
  set :sessions, true

  require 'sinatra/activerecord'
  require './helpers/render_partial'
  require './lib/network'
  require './models/user'
  require './models/time_log'

  get '/' do
    authenticate_user!

    @day_from = 1.weeks.ago.to_date
    @day_to = Date.today
    @time_logs = TimeLog.where(user_id: current_user.id).where("day >= ? AND day <= ?", @day_from, @day_to)
    @days = (@day_from..@day_to).to_a

    haml :index
  end

  get '/profile' do
    authenticate_user!

    haml :profile
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

  get '/log_time' do
    authenticate_user!

    haml :log_time
  end

  post '/create_time_log' do
    authenticate_user!

    time_log = TimeLog.new(params['time_log'])
    time_log.user_id = current_user.id

    if time_log.save
      redirect '/'
    else
      haml :log_time
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

    def gravatar_icon(user_email = '', size = 40)
      gravatar_url ||= 'https://secure.gravatar.com/avatar/%{hash}?s=%{size}&d=mm'
      user_email.strip!
      sprintf gravatar_url, hash: Digest::MD5.hexdigest(user_email.downcase), size: size
    end

    def link_to(title, path, opts)
      "<a href='#{path}' class='#{opts[:class]}'>#{title}</a>"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
