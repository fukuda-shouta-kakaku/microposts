class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [:show]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
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
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :nickname, :place, :description,
                                 :password_confirmation)
  end

  def set_user
    @user = User.find_by_id(params[:id]) \
      or render text: "404", status: 404
  end

end
