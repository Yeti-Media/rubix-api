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
  param :image_type, ["document","photo"], short: "Type of image", desc: "Type of image. A document is expected to be full of text and well aligned. A photo is expected to contain some scenery and some text, not necessarily aligned in any particular way."
  example '{"values":[{"text":"this is \na\ntest"}]}' 

  def create
    
    begin
      if scenario = create_scenario('ocr')
        matcher = Anakin::OCR.new
        @result = matcher.ocr(scenario: scenario, flags: params)
        scenario.save
        render json: @result
      else
        render json: {error: "Scenario not provided"}, status: :bad_request
      end
    rescue Anakin::GeneralError => e
      render json: {error: 'something unexpected happened. We are resolving this conflict. Thank tou', log: e.message}, status: 500
    end
  end

  private

  def create_scenario(category)
    if params[:file].present?
      attrs = {file: params[:file]}
    elsif params[:remote_file_url].present?
      attrs = {remote_file_url: params[:remote_file_url]}
    else
      return false
    end
    attrs[:category_id] = Category.find_by(title: category).id
    params = ActionController::Parameters.new(attrs)
    Scenario.new(params.permit(:file, :remote_file_url,:category_id))
  end

end
