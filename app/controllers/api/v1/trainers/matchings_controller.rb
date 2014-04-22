class Api::V1::Trainers::MatchingsController < Api::V1::BaseController

  def show
    trainer = Anakin::Trainer.new(@user)
    if trainer.train!
      render json: {status: 'ok'}, status: :ok
    else
      render json: {error: "trainer not updated"}, status: :bad_request
    end
  end
end
