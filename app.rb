# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments.rb'


class Post < ActiveRecord::Base
end
