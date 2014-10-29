# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    name "Joe Tester"
    text "A nice comment."
    article nil
  end
end
