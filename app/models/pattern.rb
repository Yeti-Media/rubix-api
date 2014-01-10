class Pattern < ActiveRecord::Base
	mount_uploader :file, AssetUploader

	belongs_to :user
  belongs_to :category

	#validates :file_exist, :file_is_image
  validates :category_id, presence: true
	validates :label, presence: true
  validates :aid, uniqueness: true

  after_initialize :add_aid

  private

  def add_aid
    aid_valid = false
    while !aid_valid
      self.aid = SecureRandom.base64(25).tr('+/=lIO0', 'pqrsxyz')
      aid_valid = valid_attribute?(:aid)
    end
  end

  def category=(value)
    if !category_id.present?
      self.category_id = Category.find_by(title: value)
    end
  end

  def category
    category.title
  end

  def valid_attribute?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end
end
