class UsersController < ApplicationController

  before_action :set_user, only: [:favorites]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user.id)
  end


  def follows
   user = User.find(params[:id])
   @users = user.following_users
  end

 def followers
   user = User.find(params[:id])
   @users = user.follower_users
 end

 def favorites
   favorites = Favorite.where(user_id: @user.id).pluck(:post_id)
   @favorite_posts = Post.find(favorites)
 end

 def withdraw
   @user = User.find(current_user.id)
   @user.update(is_deleted: true)
   reset_session
   flash[:notice] = "退会しました"
   redirect_to root_path
 end

private
def user_params
  params.require(:user).permit(:name, :title, :body, :profile_image)
end

def set_user
  @user = User.find(params[:id])
end

end