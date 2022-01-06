class GroupPostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :destroy]
  
  def create
    @group = Group.find(params[:id])
    @post = @group.group_posts.build(group_post_params)
    if @post.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      @posts = @group.group_posts.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private
  
  def group_post_params
    params.require(:group_post).permit(:content).merge(user_id: current_user.id)
  end
  
  def correct_user
    @post = current_user.group_posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
