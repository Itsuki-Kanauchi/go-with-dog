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
    @post = Post.find(params[:id])
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), success: "更新が完了しました！"
    else
      flash.now[:danger] = "更新に失敗しました。入力内容を確認してください。"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, success: "削除が完了しました！"
  end

  private

  def post_params
    permitted = params.require(:post).permit(:title, :address, :body, images: [])
    
    if permitted[:images].present?
      # 空ファイルが混ざってる場合は除去
      permitted[:images].reject!(&:blank?)
    end
  
    permitted.delete(:images) if permitted[:images].blank?
    
    permitted
  end
    
end
