class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to posts_path
    else
      flash[:notice] = check_for_error user
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private

  def check_email
    if params[:session][:email].empty?
      "Mail ID is empty"
    elsif not params[:session][:email] =~  /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
      "Invalid Mail ID"
    end
  end

  def check_password(user)
    unless user.authenticate(params[:session][:password])
      "Incorrect password, pls try again!"
    end
  end

  def check_for_error(user)
    flash[:error] = check_email
    return "email" if flash[:error]
    flash[:error] = check_password user
    return "wrong-password" if flash[:error]
  end

end
