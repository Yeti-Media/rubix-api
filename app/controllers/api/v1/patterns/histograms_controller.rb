class Api::V1::Patterns::HistogramsController <  Api::V1::BaseController

  resource_description do
    resource_id "Histogram Comparison"
    formats ["JSON"]
    param :access_token, String, desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      Hstogram comparison between patterns
    EOS
  end

  api :POST, "/api/v1/patterns/histogram", "endpoint for get results of histogram comparison between an scenario and patterns"
  param :file, File, desc: "Image file"
  param :remote_file_url, String, desc: "URL of an image file"
  param :min , Integer, desc: "Minimum Percetange required"
  param :method , String, desc: "Comparison Method: correlative or intersection method. Values: 'corr' | 'inter'"
  param :matching , String, desc: "Matching Type: 'gray' , 'color' or 'HSV' matching types. If this parameter is not provided, the app will perform the three matches and will provide the highest percentage"
  example '{"matches":[{"pattern": "internalUniqueID","percentage": 99,"label": "woods1", pattern_url: "/path/to/pattern/image",...]}' 

  def create
    scenario = create_scenario
    matcher = Anakin::Histogram.new(user: @user, scenario: scenario, flags: params)
    begin
      @result = matcher.process!
      render json: @result
    rescue Anakin::GeneralError => e
      render json: {error: 'something unexpected happened. We are resolving this conflict. Thank tou', log: e.message}, status: 500
    end
  end




end
