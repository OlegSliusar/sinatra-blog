# app.rb

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require './environments.rb'

enable :sessions

class Post < ActiveRecord::Base
  validates :title, presence: true, length: { minimum: 5 }
  validates :body, presence: true
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

post "/posts" do
 @post = Post.new(params[:post])
 if @post.save
   flash[:success] = 'Congrats! Love the new post. (This message will disappear in 4 seconds.)'
   redirect "posts/#{@post.id}"
 else
   flash[:danger] = 'Something went wrong. Try again. (This message will disappear in 4 seconds.)'
   redirect "posts/create"
 end
end

get "/posts/:id" do
  @post = Post.find(params[:id])
  @title = @post.title
  erb :"posts/view"
end
