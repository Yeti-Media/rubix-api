class Pattern < ActiveRecord::Base
	mount_uploader :file, AssetUploader
	belongs_to :user
	#validates :file_exist, :file_is_image
	validates :label, :presence => true
  validates :aid, unique: true

  after_initialize :add_aid

  private

  def add_aid
    aid_valid = false
    while !aid_valid
      self.aid = SecureRandom.base64(25)
      aid_valid = aid.valid_attribute?(:aid)
    end
  end

  def valid_attribute?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end
end
