class Pattern < ActiveRecord::Base
	mount_uploader :file, AssetUploader
	belongs_to :user
	#validates :file_exist, :file_is_image
	validates :label, :presence => true

end
