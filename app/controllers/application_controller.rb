class ApplicationController < ActionController::Base
  	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_filter :configure_devise_params, if: :devise_controller?

  def options 
    render :text => '', :content_type => 'text/plain'
  end
  
	private
  

  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password)
    end
  end

  def check_pattern_rate_limit
    c_user = @user || current_user
    pattern_count = c_user.patterns.count
    if pattern_count >= Settings.patterns.limit
      render json: {error: "Pattern upload limit reached"}, status: 422
      return false
    end
  end

end
