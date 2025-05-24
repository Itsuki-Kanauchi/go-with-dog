class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @posts = Post.includes(:user)
  end

  def new 
    @posts = Post.new
  end

  def show
  end
end
