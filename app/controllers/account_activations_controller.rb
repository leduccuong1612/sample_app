class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t ".account_active"
      redirect_to user
    else
      flash[:danger] = t ".fail_active"
      redirect_to root_path
    end
  end
end
