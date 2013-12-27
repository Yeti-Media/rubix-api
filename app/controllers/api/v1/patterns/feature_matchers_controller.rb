class Api::V1::Patterns::FeatureMatchersController < Api::V1::BaseController

  resource_description do
    resource_id "Feature Matching"
    formats ["JSON"]
    param :access_token, "string", desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      Feature Matching endpoints
    EOS
  end

  api :GET, "/api/v1/patterns/feature_matching", "endpoint for get results of feature matching between patterns and a scenario"
  param :file, "file", desc: "Image file"
  param :remote_file_url, "string", desc: "URL of an image file"
  example '{"id": 123, "label": "abc123"}'

  def create
    scenario = create_scenario
    matcher = Anakin::FeatureMatcher.new(@user,scenario)
    @result = matcher.match!
    render json: @result
  end


  private

  def create_scenario
    if params[:file]
      attrs = {file: params[:file]}
    elsif params[:url]
      attrs = {remote_file_url: params[:url]}
    end
    Scenario.create(attrs)
  end

end
