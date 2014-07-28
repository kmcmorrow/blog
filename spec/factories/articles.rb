# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title 'New Article'
    text 'Welcome to the blog!'

    factory :article_with_comment do
      after(:create) do |article, evaluator|
        create_list(:comment, 1, article: article)
      end
    end
  end
end
