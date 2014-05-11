require 'rubygems'
require 'bundler'
require 'rake'
require "./app"
require "sinatra/activerecord/rake"
Bundler.setup

Dir["tasks/*.rake"].sort.each { |ext| load ext }
