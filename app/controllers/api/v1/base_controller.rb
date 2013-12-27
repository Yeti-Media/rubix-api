class Api::V1::BaseController < ApplicationController
  before_filter :cors_set_access_control_headers
  before_filter :authenticate_with_token!


  private


  def authenticate_with_token!
    unless @user = User.find_by_access_token(params[:access_token])
      render json: {error: 'Not Authorized'}, status: 401
    end
  end
  

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token, Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
