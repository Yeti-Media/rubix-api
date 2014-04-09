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

  api :POST, "/api/v1/patterns/ocr", "endpoint for get results of OCR processing"
  param :file, File, desc: "Image file"
  param :remote_file_url, String, desc: "URL of an image file"
  param :rectangles, Array, desc: "Array of points. Example: [[x1,y1,x2,y2],..[x1,y1,x2,y2]]"
  example '{"values":[{"text":"this is \na\ntest"}]}' 

  def create
    scenario = create_scenario('ocr')
    matcher = Anakin::OCR.new
    begin
      @result = matcher.ocr(scenario: scenario, flags: params)
      scenario.save
      render json: @result
    rescue Anakin::GeneralError => e
      render json: {error: 'something unexpected happened. We are resolving this conflict. Thank tou', log: e.message}, status: 500
    end
  end

  private

  def create_scenario(category)
    if params[:file]
      attrs = {file: params[:file]}
    elsif params[:remote_file_url]
      attrs = {remote_file_url: params[:remote_file_url]}
    end
    attrs[:category_id] = Category.find_by(title: category).id
    params = ActionController::Parameters.new(attrs)
    Scenario.new(params.permit(:file, :remote_file_url,:category_id))
  end

end
