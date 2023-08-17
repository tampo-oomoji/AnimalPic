class UsersController < ApplicationController
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



private
def user_params
  params.require(:user).permit(:title, :body, :profile_image)
end

end