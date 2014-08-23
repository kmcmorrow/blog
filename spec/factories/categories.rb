# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  sequence :name do |n|
    "Category #{n}"
  end
  
  factory :category do
    name

    factory :category_with_articles do
      after(:create) do |category|
        category.articles << create_list(:article, 3)
      end
    end
  end
end
