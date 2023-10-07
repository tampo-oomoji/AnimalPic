class RelationshipsController < ApplicationController

  before_action :authenticate_user!
  def create

    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def follows
    user = User.find(params[:user_id])
    @user = user.name
    @users = user.following_users
  end

  def followers
    user = User.find(params[:user_id])
    @user = user.name
    @users = user.follower_users
  end

end
