class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = @users.where.not(id: current_user.id).order(created_at: :desc)
  end

  def edit
    @user
  end

  def show
    @user
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to users_path if @user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:role_user)
    end
end
