class Api::V1::PatternsController < Api::V1::BaseController

  def create
    @pattern = @user.patterns.new(params[:pattern])
    if @pattern.save
      render nothing: true , status: :ok
    else
      render json: {error: @pattern.errors.full_messages.to_sentence} , status: 422
    end
  end
end
