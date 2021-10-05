class PostsController < ApplicationController

  before_action :verify_login, only: [:new, :edit]

  def about

  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 9).order(created_At: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(authenticated_params)
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    redirect_to posts_path unless @post.user == current_user || current_user.admin?
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(authenticated_params)
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def authenticated_params
    params.require(:post).permit(:title, :body)
  end

  def verify_login
    redirect_to login_path unless logged_in?
  end

end
