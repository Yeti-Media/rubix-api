class PatternsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_category, only: [:index]
  before_filter :load_pattern, only: [:edit, :destroy, :update]

  def index
  	@patterns = current_user.patterns
    @patterns = @patterns.where(category_id: params[:category_id]) if params[:category_id]
    @patterns = @patterns.page(params[:page]).per(20)
  end

  def new
    @pattern = Pattern.new
  end

  def edit
  end

  def create
    @pattern = current_user.patterns.new(params.require(:pattern).permit(:label, :file, :category_id))
    notify(@pattern.save, "Pattern succesfully created!", "Pattern creation failed!")
  end

  def update
    @pattern.attributes = params.require(:pattern).permit(:label, :file, :category)
    notify(@pattern.save, "Pattern succesfully updated!", "Pattern update failed!")
  end

  def destroy
    @pattern.remove_file!
    ok = @pattern.destroy
    notify(ok, "Pattern succesfully deleted!", "Pattern deletion failed!")
  end

  private

  def load_category
    @category = Category.find(params[:category_id]) if params[:category_id]
  end

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
