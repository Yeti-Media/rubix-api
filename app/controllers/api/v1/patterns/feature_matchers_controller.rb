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
  example '[{"scenario": {"url": "/path/to/scenario"},
             "values":[{"center":{"x":102.526206970215,
                                 "y":94.42138671875},
                        "keypoints":[...]}
                       ]
            }..]' 

  def create
    begin
      if scenario = create_scenario('matching')
        matcher = Anakin::FeatureMatcher.new
        @result = matcher.matching(@user, scenario: scenario.id)
        render json: @result
      else
        render json: {error: "Scenario not provided"}, status: :bad_request
      end
    rescue Anakin::GeneralError => e
      render json: {error: 'something unexpected happened. We are resolving this conflict. Thank tou', log: e.message.gsub(/opencv/, 'anakin')}, status: 500
    end
  end


end
