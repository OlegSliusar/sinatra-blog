# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require './environments.rb'


class Post < ActiveRecord::Base
end

helpers do
  def title
    if @title
      "#{@title}"
    else
      'Welcome.'
    end
  end
end

get '/' do
  @posts = Post.order('created_at DESC')
  @title = 'Welcome.'
  erb :'posts/index'
end

get "/posts/create" do
  @title = "Create post"
  @post = Post.new
  erb :"posts/create"
end

get "/posts/:id" do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :"posts/view"
end
