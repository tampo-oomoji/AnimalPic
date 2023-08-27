class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました。"
  end
  
  protected
  
  def reject_end_user
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    if @end_user
      if @end_user.valid_password?(params[:end_user][:password]) && (@end_user.is_deleted == true)
        flash[:notice] = "退会済みです"
        redirect_to new_end_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end 
    else
      flash[:notice] = "該当ユーザーが見つかりません"
    end 
  end 
    
end