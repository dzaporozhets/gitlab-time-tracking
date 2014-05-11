require 'rubygems'
require 'sinatra/base'
require 'haml'

class GitLabTimeTracking < Sinatra::Base
  require './helpers/render_partial'

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
