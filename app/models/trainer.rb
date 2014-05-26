class Trainer < ActiveRecord::Base
  belongs_to :user
  has_many :patterns

  

  mount_uploader :if_file, DataUploader
  mount_uploader :xml_file, DataUploader

  #scope :availables, lambda{where("trainers.patterns_count < #{Settings.patterns.limit}")}

  def self.availables
    self.joins('LEFT JOIN patterns ON patterns.trainer_id = trainers.id').
            group('trainers.id').
            having("COUNT(patterns.id) < #{Settings.patterns.limit}")
  end

end
