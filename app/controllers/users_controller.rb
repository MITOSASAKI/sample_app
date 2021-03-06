class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]  
  before_action :correct_user, only: [:edit, :update]
 
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success]="ユーザー登録完了しました！ようこそ#{@user.name}さん！"
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end
 

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="ユーザー 情報を更新しました！"
      redirect_to @user
    else
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
        redirect_to root_url
      end
    end
  end
