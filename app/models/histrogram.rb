class Histrogram < ActiveRecord::Base
  belongs_to :pattern

  validates :color, :gray, :hsv, presence: true

end
