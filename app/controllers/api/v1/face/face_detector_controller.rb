class Api::V1::Face::FaceDetectorController < Api::V1::BaseController

  resource_description do
    resource_id "FaceDetector"
    formats ["JSON"]
    param :access_token, String, desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      Face detector endpoints
    EOS
  end

  api :POST, "/api/v1/face/detect", "endpoint to get results of face detection"
  param :file, File, desc: "Image file"
  example '{"faces":[{"h":41,"w":41,"x":268,"y":70},{"h":40,"w":40,"x":12,"y":90}]}'

  def create
    begin
      scenario = new_scenario('ocr')
      matcher = Anakin::FaceDetector.new
      @result = matcher.detect_face(scenario: scenario, flags: params)
      scenario.save
      render json: @result
    rescue Anakin::GeneralError => e
      render json: {error: 'Failure in face detection.', log: e.message}, status: 500
    end
  end

end
