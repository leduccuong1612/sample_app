class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".notification"
      redirect_to root_path
    else
      flash.now[:danger] = t ".danger"
      render :new
    end
  end

  def show
    @microposts = @user.microposts.order_desc.page params[:page]
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:danger] = t ".danger"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash.now[:success] = t ".success"
    else
      flash.now[:danger] = t ".danger"
    end
    redirect_to users_path
  end

  def following
    @title = t ".following"
    @user = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render :show_follow
  end

  def followers
    @title = t ".followers"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:danger] = t ".danger"
    redirect_to users_path
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
