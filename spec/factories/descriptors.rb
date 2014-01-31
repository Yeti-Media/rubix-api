# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :descriptor, :class => 'Descriptors' do
    body "MyText"
    pattern nil
  end
end
