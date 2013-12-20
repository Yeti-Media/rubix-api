FactoryGirl.define do
 factory :user do
   sequence(:email) { |n| "user#{n}@example.com" }
   password 'secret_pass'
   password_confirmation 'secret_pass'
 end
end