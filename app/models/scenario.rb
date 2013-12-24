class Scenario < ActiveRecord::Base
  
  mount_uploader :file, ScenarioUploader

end
