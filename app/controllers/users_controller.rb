class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash.now[:success] = t ".success"
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def show
    @user = User.find_by id: params[:id]
    redirect_to root_path unless @user
  end

  private
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
