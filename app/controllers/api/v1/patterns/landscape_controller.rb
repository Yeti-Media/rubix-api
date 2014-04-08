class Api::V1::Patterns::LandscapeController <  Api::V1::BaseController

=begin
resource_description do
    resource_id "Landscape Comparison"
    formats ["JSON"]
    param :access_token, String, desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      Determine what type of landscape is
    EOS
  end

  api :GET, "/api/v1/patterns/landscape", "endpoint for get results of landscape type"
  param :file, File, desc: "Image file"
  param :remote_file_url, String, desc: "URL of an image file"
  param :min , Integer, desc: "Minimum Percetange required"
  example '{"label":"scene",
            "values":[{"center":{"x":102.526206970215,
                                 "y":94.42138671875},
                       "keypoints":[{"angle":341.342712402344,
                                     "pos":{"x":100.40860748291,"y":112.718078613281},
                                     "response":23270.0703125,"size":21},...]}' 
=end

  def create
    scenario = create_scenario
    matcher = Anakin::Landscape.new
    begin
      @result = matcher.landscape(user_id: @user.id, scenario_id: scenario_id, flags: params)
      render json: @result
    rescue Anakin::GeneralError => e
      render json: {error: 'something unexpected happened. We are resolving this conflict. Thank tou', log: e.message}, status: 500
    end
  end

end
