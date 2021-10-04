class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(authenticated_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path @user
    else
      redirect_to signup_path
    end
  end

  def index
    @users = User.order(username: :asc)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(authenticated_params)
      redirect_to user_path(@user)
    else
      redirect_to edit_user_path(@user)
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to signup_path
  end

  private

  def authenticated_params
    params.require(:user).permit(:username,:email,:password)
  end
end
