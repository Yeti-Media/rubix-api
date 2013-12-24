class Api::V1::BaseController < ApplicationController
  before_filter :authenticate_with_token!


  private


  def authenticate_with_token!
    unless @user = User.find_by_access_token(params[:access_token])
      render json: {error: 'Not Authorized'}, status: 401
    end
  end
end
