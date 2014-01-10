class Api::V1::CategoriesController < Api::V1::BaseController

  resource_description do
    resource_id "Pattern Category List"
    formats ["JSON"]
    param :access_token, String, desc: "Current user's access token", required: true
    description <<-EOS
      == Description
      Category List of patterns
    EOS
  end

  api :GET, "/api/v1/categories", "List categories for pattern creation"
  example '[{"id": 1, "title": "ocr"}{"id": 2, "title": "comparison"}]'

  def index
    render json: Category.all
  end
end
