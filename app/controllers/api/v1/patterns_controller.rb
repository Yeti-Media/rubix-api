class Api::V1::PatternsController < Api::V1::BaseController

  resource_description do
    resource_id "Pattern creation"
    formats ["JSON"]
    param :access_token, String, desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      Pattern endpoint for pattern management
    EOS
  end

  api :GET, "/api/v1/patterns", "Add a new pattern to the training set"
  param :pattern, Hash do
    param :file, File, desc: "Image file", required: true
    param :label, String, desc: "Label (used for identification). If the image has the category 'ocr' Then the label should contain the text in the image", required: true
    param :category, String, desc: "Category: (matching, comparison, ocr or face)", required: true
    param :category_id, Integer , desc: "Category ID: retrieved from /api/v1/categories endpoint. Can be provided if category is not present", required: true
  end
  example '{"id": 123, "label": "abc123", "category_id": 1, "":"http://server.example/path/to/file"}'
 

  def create
    @pattern = @user.patterns.new(params[:pattern])
    if @pattern.save
      render json: @pattern.to_json(only: [:id,:label, :file, :category_id, :category]) , status: :ok
    else
      render json: {error: @pattern.errors.full_messages.to_sentence} , status: 422
    end
  end
end
