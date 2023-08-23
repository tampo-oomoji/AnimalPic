class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search

  def after_sign_in_path_for(resource)

    root_path
  end
  
  def search
    @q = Post.ransack(params[:q])
    @post = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end 

  def after_sign_out_path_for(resource)
    homes_about_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
