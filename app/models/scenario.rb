class Scenario < ActiveRecord::Base

  mount_uploader :file, ScenarioUploader
  
  belongs_to :user
  belongs_to :category

  before_create :extract_information

  def category_name
    category.title
  end

  private

  def extract_information
    case self.category_name
    when 'matching'
      extractor = Anakin::Extractor.new(self.category_name, self)
      body = extractor.extract!
      self.descriptors = body['data']
    end
  end
  
end
