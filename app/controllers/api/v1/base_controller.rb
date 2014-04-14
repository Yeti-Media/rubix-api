class Api::V1::BaseController < ApplicationController
  include Controllers::Authentication

  before_filter :cors_set_access_control_headers
  before_filter :authenticate_api_user!
  protect_from_forgery with: :null_session

  protected

  def create_scenario(category)
    if params[:file]
      attrs = {file: params[:file]}
    elsif params[:remote_file_url]
      attrs = {remote_file_url: params[:remote_file_url]}
    end
    attrs[:category_id] = Category.find_by(title: category).id
    params = ActionController::Parameters.new(attrs)
    Scenario.create(params.permit(:file, :remote_file_url,:category_id))
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = '*, X-Requested-With, X-Prototype-Version, X-CSRF-Token, Content-Type'
    headers['Access-Control-Max-Age'] = "1728000"
  end
end
