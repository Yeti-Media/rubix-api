class Api::V1::Patterns::FeatureMatchersController < Api::V1::BaseController

  resource_description do
    resource_id "Feature Matching"
    formats ["JSON"]
    param :access_token, String, desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      Feature Matching endpoints
    EOS
  end

  api :POST, "/api/v1/patterns/feature_matcher", "endpoint for get results of feature matching between patterns and a scenario"
  param :file, File, desc: "Image file"
  param :remote_file_url, String, desc: "URL of an image file"
  param :mma, Integer, desc: "Minimum Amount of matches"
  param :mr, Float, desc: "Minimum Ratio"
  example '{"label":"scene",
            "values":[{"center":{"x":102.526206970215,
                                 "y":94.42138671875},
                       "keypoints":[{"angle":341.342712402344,
                                     "pos":{"x":100.40860748291,"y":112.718078613281},
                                     "response":23270.0703125,"size":21},...]}' 

  def create
    scenario = create_scenario('matching')
    matcher = Anakin::FeatureMatcher.new
    begin
      @result = matcher.matching(@user, scenario_id: scenario.id, flags: params)
      render json: @result.compact
    rescue Anakin::GeneralError => e
      render json: {error: 'something unexpected happened. We are resolving this conflict. Thank tou', log: e.message.gsub(/opencv/, 'anakin')}, status: 500
    end
  end


end
