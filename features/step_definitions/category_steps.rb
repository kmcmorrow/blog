Given(/^there (?:are|is) (#{NUMBER}) categor(?:y|ies)$/) do |num_categories|
  @categories = []
  num_categories.times do |n|
    category = FactoryGirl::create(:category,  name: "Category #{n}")
    category.articles << FactoryGirl::create(:article)
    @categories << category
  end
end

Given(/^there is an article with (\d+) categories$/) do |num_categories|
  @article = FactoryGirl::create(:article, title: 'Article with categories')
  3.times do |num|
    @article.categories << @categories[num]
  end
end

When(/^I click on a category$/) do
  click_link 'Category 0'
end

Then(/^I should see (#{NUMBER}) categories$/) do |num_categories| 
  num_categories.times do |n|
    expect(page).to have_content("Category #{n}")
  end
end

Then(/^I should see the articles in that category$/) do
  @categories.first.articles.each do |article|
    expect(page).to have_content(article.title)
    expect(page).to have_content(article.text)
  end
end

Then(/^I should see links to the categories$/) do
  3.times do |num|
    expect(page).to have_link("Category #{num}")
  end
end

When(/^I create a new category$/) do
  click_link 'Add category'
  fill_in 'Name', with: 'New Category'
  click_button 'Create Category'
end

Then(/^I should see the new category$/) do
  expect(page).to have_link('New Category', category_path(Category.last))
end

When(/^I change the category name$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the new category name$/) do
  pending # express the regexp above with the code you wish you had
end
