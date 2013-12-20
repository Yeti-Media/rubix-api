class PatternsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_pattern, only: [:edit, :destroy, :update]

  def index
  	@patterns = current_user.patterns
  end

  def new
    @pattern = Pattern.new
  end

  def edit
    
  end

  def create
    @pattern = current_user.patterns.new(params.require(:pattern).permit(:label, :file))
    notify(@pattern.save, "Pattern succesfully created!", "Pattern creation failed!")
  end

  def update
    @pattern.attributes = params.require(:pattern).permit(:label, :file)
    notify(@pattern.save, "Pattern succesfully updated!", "Pattern update failed!")
  end

  def destroy
    @pattern.remove_file!
    ok = @pattern.destroy
    notify(ok, "Pattern succesfully deleted!", "Pattern deletion failed!")
  end

  private

  def load_pattern
    @pattern = current_user.patterns.find(params[:id])
  end

  def notify(good, msgGood, msgBad)
    if good
      flash[:notice] = msgGood
      redirect_to patterns_path
    else
      flash[:error] = msgBad
      render :new
    end
  end


end
