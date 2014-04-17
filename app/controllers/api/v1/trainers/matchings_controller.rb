class Api::V1::Trainers::MatchingsController < Api::V1::BaseController

  def show
    trainer = Anakin::Trainer.new(@user)
    trainer.train!
    render nothing: true, status: :ok
  end
end
