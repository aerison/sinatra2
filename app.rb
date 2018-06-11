gem 'json','~> 1.6'
#sinatra 필요해
require 'sinatra'
#sinatra/reloader필요해
require 'sinatra/reloader'
#'/'경로로 오면 index.html파일 보내줘
require 'data_mapper' # metagem, requires common plugins too.

#datamapper 로그찍기
DataMapper::Logger.new($stdout,:debug)
# need install dm-sqlite-adapter
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/blog.db")
#post 객체생성
class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, String
  property :body, Text
  property :created_at, DateTime
end

# Perform basic sanity checks and initialize all relationships
# Call this when you've defined all your models
DataMapper.finalize

# automatically create the post table
Post.auto_upgrade!

before do
    p '***************************'
    p params
    p '***************************'
end


get '/' do
    send_file 'index.html'
end

get '/lunch' do
    lunch=['bab','gogi','soup']
    @todaymenu=lunch.sample
    erb:lunch
end

#'/lunch'경로로 오면 @lunch.sample을 lunch.erb에서 보여줘

#게시글을 모두 보여주는 곳
get '/posts' do
    @posts=Post.all
    erb :'posts/posts'
end

#게시글을 쓸수 있는 곳
get '/posts/new' do
    
    erb:'posts/new'
end

get '/posts/create' do
    @title=params[:title]
    @body=params[:body]
    Post.create(title: @title, body: @body)
    erb:'posts/create'
end

