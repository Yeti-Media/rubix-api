class Api::V1::Patterns::FeatureMatchersController < Api::V1::BaseController

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
