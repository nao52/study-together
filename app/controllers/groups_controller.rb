class GroupsController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @groups = Group.order(id: :desc).page(params[:page]).per(25)
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
      @groups = current_user.group.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'グループの作成に失敗しました。'
      render 'groups/new'
    end
  end
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:success] = 'グループ名は正常に更新されました'
      redirect_to groups_url
    else
      flash.now[:danger] = 'グループ名は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = 'グループを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def group_params
    params.require(:group).permit(:name)
  end
end
