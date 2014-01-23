class Api::V1::Patterns::OcrsController < Api::V1::BaseController

  resource_description do
    resource_id "OCR"
    formats ["JSON"]
    param :access_token, String, desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      OCR endpoints
    EOS
  end

  api :GET, "/api/v1/patterns/ocr", "endpoint for get results of OCR processing"
  param :file, File, desc: "Image file"
  param :remote_file_url, String, desc: "URL of an image file"
  param :rectangles, Array, desc: "Array of points. Example: [[x1,y1,x2,y2],..[x1,y1,x2,y2]]"
  example '{"values":[{"text":"this is \na\ntest"}],"scenario_url":"/uploads/scenario/file/171/test_ocr.png"}' 

  def create
    scenario = create_scenario
    matcher = Anakin::OCR.new(user: @user, scenario: scenario, flags: params)
    begin
      @result = matcher.process!
      render json: @result
    rescue Anakin::GeneralError => e
      render json: {error: 'something unexpected happened. We are resolving this conflict. Thank tou', log: e.message}, status: 500
    end
  end

end
