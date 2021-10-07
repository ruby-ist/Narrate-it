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
      flash[:notice] = check_error @user
      render :new
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
    redirect_to user_path(@user) unless current_user == @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(authenticated_params)
      redirect_to user_path(@user)
    else
      flash[:error] = check_username @user
      render :edit
    end
  end

  def destroy
    user = User.find(params[:id])
    session[:user_id] = nil unless current_user.admin?
    user.destroy
    redirect_to signup_path
  end

  private

  def authenticated_params
    params.require(:user).permit(:username,:email,:password)
  end

  def check_password(user)
    if user.errors.include?(:password)
      "Invalid Password!"
    end
  end

  def check_email
    if params[:user][:email].empty?
      "Mail ID is empty"
    elsif not params[:user][:email] =~  /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      "Invalid Mail ID"
    end
  end

  def check_username(user)
    if params[:user][:username].empty?
      "The username field is empty"
    elsif params[:user][:username].length < 4
      "The username is too small!"
    elsif params[:user][:username].length > 25
      "The username is too big!!"
    elsif user.errors.include?(:username)
      "That username is already taken"
    end
  end

  def check_error(user)
    flash[:error] = check_username user
    return "username" if flash[:error]
    flash[:error] = check_email
    return "email" if flash[:error]
    flash[:error] = check_password user
    return "password" if flash[:error]
  end

end
