class UsersController < ApplicationController
  load_and_authorize_resource

  def index;end

  def edit;end

  def show;end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:role_user)
    end
end
