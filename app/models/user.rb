class User < ActiveRecord::Base

  

  has_many :patterns
  has_many :scenarios
  has_many :trainers


  before_create :generate_access_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #validates :account_type , inclusion: {in: Settings.user.account_types}

  Settings.user.account_types.each do |ac|
    scope ac, lambda{ where(account_types: ac)}
  end

=begin
    <application>
<id>1409610341502</id>
<created_at>2014-03-26T19:14:27Z</created_at>
<updated_at>2014-04-10T20:04:19Z</updated_at>
<state>live</state>
<user_account_id>2445580835242</user_account_id>
<end_user_required>false</end_user_required>
<user_key>dc929138f2cb3de2fad5e377b09e2b37</user_key>
<provider_verification_key>2bb7e887a7441734aa19dfcde2bb691e</provider_verification_key>
<plan custom="false" default="true">
<id>2357355729282</id>
<name>Basic</name>
<type>application_plan</type>
<state>published</state>
<service_id>2555417707192</service_id>
<end_user_required>false</end_user_required>
<setup_fee>0.0</setup_fee>
<cost_per_month>0.0</cost_per_month>
<trial_period_days/>
<cancellation_period>0</cancellation_period>
</plan>
<name>Rubix's App</name>
<description>Description of your default application</description>
<extra_fields/>
</application>
=end

  def self.create_threescale_user(object)
   password = SecureRandom.hex
   create!(third_party_id: object.at('id').inner_text,
          access_token: object.at('user_key').inner_text,
          account_type: 'threescale',
          email: "#{object.at('id').inner_text}@3scale.com", 
          password: password,
          password_confirmation: password)
  end

  def get_access_token
  	self.access_token
  end

  private

  def generate_access_token
  	self.access_token ||= SecureRandom.hex
  end

end
