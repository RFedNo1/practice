class PostsController < ApplicationController

    before_action :logined_user?, only: [:new, :create, :edit, :update, :destroy]
    before_action :ensure_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @likes_count = Like.where(post_id: params[:id]).count
  end

  def new
    @post = Post.new
  end

  def create
      @post = Post.new(content: params[:post][:content], user_id: @current_user.id)
      if @post.save
        flash[:notice] = "投稿が完了しました！"
        redirect_to("/posts/index")
      else
        render("posts/new")
      end
  end

  def edit
      @post = Post.find_by(id: params[:id])
  end
    
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:post][:content]
    if @post.save
        flash[:notice] = "投稿を編集しました"
        redirect_to("/posts/index")
    else
        render("posts/edit")
    end
  end

  def destroy
    post = Post.find_by(id: params[:id])
    post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
  end

  def ensure_user
    post = Post.find_by(id: params[:id])
    if @current_user.id != post.user.id
        flash[:notice] = "権限がありません"
        redirect_to("/posts/index")
    end
  end

  def likes
    # @likes = Like.where()
  end
end
