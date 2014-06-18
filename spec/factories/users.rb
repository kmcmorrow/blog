# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'admin@example.org'
    password 'secretpass'
  end
end
