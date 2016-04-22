class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :authenticate_user, only: [:show, :edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # FIXME: Create session for the sake of redirecting
      session[:user_id] = @user.id

      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      flash[:danger] = "プロフィールの更新に失敗しました。"
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :nickname, :place, :description,
                                 :password_confirmation)
  end

  def authenticate_user
    unless session[:user_id] == params[:id].to_i
      flash[:danger] = "Invalid user."
      redirect_to root_path
    end

  end
end
