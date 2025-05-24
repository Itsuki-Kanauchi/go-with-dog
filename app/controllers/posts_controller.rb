class PostsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]

  def index
    @posts = Post.includes(:user)
  end

  def new 
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: "投稿が完了しました！"
    else
      flash.now[:danger] = "投稿に失敗しました。入力内容を確認してください。"
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :body, :image)
  end
end
