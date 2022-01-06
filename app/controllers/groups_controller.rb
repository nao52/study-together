class GroupsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  before_action :set_group, only: [:show, :edit, :update, :destroy, :joineds]
  
  def index
    @groups = Group.order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    @grouppost = @group.group_posts.build 
    @groupposts = @group.group_posts.order(id: :desc).page(params[:page]).per(25)
  end
  
  def new
    @group = Group.new
  end
  
  def create
    @group = current_user.groups.build(group_params)
    if @group.save
      flash[:success] = 'グループを作成しました。'
      redirect_to groups_url
    else
      @groups = current_user.groups.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'グループの作成に失敗しました。'
      render 'groups/new'
    end
  end
  
  def edit
  end
  
  def update
    if @group.update(group_params)
      flash[:success] = 'グループ名は正常に更新されました'
      redirect_to groups_url
    else
      flash.now[:danger] = 'グループ名は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @group.destroy
    flash[:success] = 'グループを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def joineds
    @joineds = @group.joineds.page(params[:page])
  end
  
  private
  
  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :content)
  end
  
  def correct_user
    @group = current_user.groups.find_by(id: params[:id])
    unless @group
      redirect_to root_url
    end
  end
end
