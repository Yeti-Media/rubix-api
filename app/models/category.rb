class Category < ActiveRecord::Base

  has_many :patterns

  validates_uniqueness_of :title
end
