class Users::ThreescaleController < ApplicationController
  protect_from_forgery with: :null_session

  respond_to :xml

  def show
    create_user
  end

  def create
    create_user
  end

  private

  def create_user
    @xml = Nokogiri::XML(request.body.read)
    if is_application? && is_created?
      User.create_threescale_user(@xml.search('//event/object/application'))
    end
    render nothing: true
  end

  def is_application?
    @xml.search('//event/type').inner_text == 'application'
  end

  def is_created?
    @xml.search('//event/action').inner_text == 'created'
  end
end
