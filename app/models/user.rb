class User < ActiveRecord::Base

  has_many :patterns
  has_many :scenarios
  has_many :trainers


  before_create :generate_access_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def get_access_token
  	self.access_token
  end

  private

  def generate_access_token
  	self.access_token = SecureRandom.hex
  end

end
