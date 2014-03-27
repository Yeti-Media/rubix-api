# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trainer, :class => 'Trainers' do
    data ""
    user nil
  end
end
