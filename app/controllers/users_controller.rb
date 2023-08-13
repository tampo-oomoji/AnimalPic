class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def edit
    @user = User.find(params[:id])
  end


private
def user_params
  params.require(:user).permit(:title, :body, :profile_image)
end

end