class TrainersController < ApplicationController
  before_filter :authenticate_user!

  def index
    trainer = Anakin::Trainer.new(current_user)
    trailer.delay.train!
    flash[:notice] = "Index in Process"
    redirect_to :back
  end
end
