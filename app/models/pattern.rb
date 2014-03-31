class Pattern < ActiveRecord::Base
  
	mount_uploader :file, AssetUploader

	belongs_to :user
  belongs_to :category
  belongs_to :trainer, counter_cache: true
  has_one :histogram
  has_one :descriptor

	#validates :file_exist, :file_is_image
  validates :category_id, presence: true
	validates :label, presence: true
  validates :aid, uniqueness: true

  after_initialize :add_aid
  before_create :extract_information

  def category_name
    category.title
  end

  def category_name=(value)
    if !category_id.present?
      self.category = Category.find_by(title: value)
    end
  end

  private

  def add_aid
    aid_valid = false
    while !aid_valid
      self.aid = SecureRandom.base64(25).tr('+/=lIO0', 'pqrsxyz')
      aid_valid = valid_attribute?(:aid)
    end
  end

  def valid_attribute?(attribute_name)
    self.valid?
    self.errors[attribute_name].blank?
  end

  def extract_information
    case self.category_name
    when 'matching'
      extractor = Anakin::Extractor.new(self.category_name, self)
      body = extractor.extract!
      self.create_descriptor!(body: body['data'])
    end
  end
end
