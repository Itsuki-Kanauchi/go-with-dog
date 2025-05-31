class StaticPagesController < ApplicationController
  def top
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user)
  end
end
