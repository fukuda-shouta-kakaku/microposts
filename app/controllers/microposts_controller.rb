class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
      flash[:danger] = "Creating Micropost failed."
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  def re_micropost
    micropost = Micropost.find(params[:id])
    user = current_user
    unless micropost && user
      flash[:danger] = "invalid request"
      return redirect_to root_url 
    end

    re_micropost = micropost.re_micropost.build({user_id: user.id})
    if re_micropost.save
      flash[:success] = "Remicroposted!!"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "Remicroposting failed..."
      redirect_to request.referrer || root_url
    end
  end

  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end
