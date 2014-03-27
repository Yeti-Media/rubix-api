class Trainer < ActiveRecord::Base
  belongs_to :user
  has_many :patterns

  mount_uploader :if_file, DataUploader
  mount_uploader :xml_file, DataUploader

end
