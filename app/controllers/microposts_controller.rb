class MicropostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿完了！"
   else
     render 'static_pages/home'
    end
  end

  def destroy
  @micropost = current_user.microposts.find_by(id: params[:id])
  redirect_to root_url if @micropost.nil?
  @micropost.destroy
  flash[:success] = "投稿を削除しました"
  redirect_to root_url
  end

  private

  def micropost_params
   params.require(:micropost).permit(:content, :picture)
  end

end
