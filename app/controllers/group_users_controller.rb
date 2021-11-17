class GroupUsersController < ApplicationController
  before_action :require_user_logged_in

  def create
    group = Group.find(params[:group_id])
    current_user.join(group)
    flash[:success] = 'グループに参加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    group = Group.find(params[:group_id])
    current_user.unjoin(group)
    flash[:success] = 'グループを抜けました。'
    redirect_back(fallback_location: root_path)
  end
end
