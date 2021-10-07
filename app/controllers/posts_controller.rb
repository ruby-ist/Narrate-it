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
      flash[:error] = check_error

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

  def check_error
    if params[:post][:title].empty?
      "The post should have a valid title."
    elsif params[:post][:title].length < 3
      "Title is too short. Minimum is 3 characters."
    elsif params[:post][:title].length > 25
      "Title is too big. Maximum is 25 characters."
    elsif params[:post][:body].empty?
      "The post contents are empty!!!"
    elsif params[:post][:body].length < 100
      "Content should have at least 100 characters"
    end
  end

end
