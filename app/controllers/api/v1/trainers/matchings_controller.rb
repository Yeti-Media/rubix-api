class Api::V1::Trainers::MatchingsController < Api::V1::BaseController

  def index
    trainer = Anakin::Trainer.new(current_user)
    trailer.delay.train!
    render nothing: true, status: :ok
  end
end
