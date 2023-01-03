class SessionsController < ApplicationController
  def sign_up
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Signed up successfully."
    else
      render :sign_up
    end
  end

  def sign_in
    @user = User.new
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Signed in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :sign_in
    end
  end

  def sign_out
    reset_session
    redirect_to root_url, notice: "Signed out successfully."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
