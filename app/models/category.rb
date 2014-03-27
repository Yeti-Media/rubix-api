class Category < ActiveRecord::Base

  has_many :patterns
  has_many :scenarios

  validates_uniqueness_of :title
end
