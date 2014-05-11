APP_ROOT = File.dirname(__FILE__)

require 'rubygems'
require 'sinatra/base'
require 'haml'

class GitLabTimeTracking < Sinatra::Base
  require './helpers/render_partial'
  set :database_file, "#{APP_ROOT}/config/database.yml"
  require 'sinatra/activerecord'

  get '/' do
    haml :index
  end

  get '/login' do
    haml :login
  end

  post '/user_sessions' do
    if true
      redirect '/'
    else
      haml :login
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
