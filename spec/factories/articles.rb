# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title 'New Article'
    text 'Welcome to the blog!'
    status 'published'

    factory :draft_article do
      status 'draft'
    end

    factory :article_with_comment do
      after(:create) do |article, evaluator|
        create_list(:comment, 1, article: article)
      end
    end

    factory :article_with_categories do
      after(:create) do |article|
        article.categories << create_list(:category, 3)
      end
    end
  end

end
