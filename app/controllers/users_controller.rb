class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :followings, :followers]
  before_action :correct_user, only: [:edit, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :followings, :followers, :likes, :joinings]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールは正常に更新されました。'
      redirect_to @user
    else
      flash.now[:danger] = 'プロフィールの更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @user.destroy

    flash[:success] = 'ユーザは正常に削除されました'
    redirect_to toppage_url
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
  end
  
  def likes
    @likes = @user.likes.page(params[:page])
  end
  
  def joinings
    @joinings = @user.joinings.page(params[:page])
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :goal, :status)
  end
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_url
    end
  end
end
