class Admin::UsersController < ApplicationController
 def withdraw
  @user = User.find(params[:id])
  @user.update(is_deleted: true)
  reset_session
  flash[:notice] = "退会しました"
  redirect_to root_path
 end
end
