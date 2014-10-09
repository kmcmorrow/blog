Given(/^there (?:are|is) (\d+) (un)?published articles?$/) do |num_articles, unpublished|
  @articles = []
  Integer(num_articles).times do |n|
    if unpublished
      @articles << FactoryGirl.create(:draft_article, title: "Article#{n}")
    else
      @articles << FactoryGirl.create(:article, title: "Article#{n}")
    end
  end
  @article = @articles.first
end

When(/^I click on the article title$/) do
  click_link @article.title
end

When(/^I add a new article$/) do
  article = FactoryGirl::attributes_for(:article)
  fill_in 'Title', with: article[:title]
  fill_in 'Text', with: article[:text]
  click_button 'Create'
end

Given(/^I add a new article in a category$/) do
  article = FactoryGirl::attributes_for(:article)
  fill_in 'Title', with: 'Article with Category'
  fill_in 'Text', with: article[:text]
  select(Category.first.name, from: 'Categories')
  click_button 'Create'
end

When(/^I click on the article$/) do
  click_link 'Article with Category'
end

When(/^I fill in new article content$/) do
  fill_in 'Title', with: 'Updated title'
  fill_in 'Text', with: 'Updated text'
end

When(/^I create a new article with (published|draft) chosen$/) do |status|
  article = FactoryGirl::attributes_for(:article)
  fill_in 'Title', with: article[:title]
  fill_in 'Text', with: article[:text]
  choose 'Published' if status == 'published'
  click_button 'Create'
end

Then(/^I should see (\d+) article(?:s)?$/) do |num_articles|
  Integer(num_articles).times do |n|
    expect(page).to have_css('h1', text: "Article#{n}")
  end
end

Then(/^I should see the article$/) do
  article = FactoryGirl::attributes_for(:article)
  expect(page).to have_css('h1', text: 'Article0')
  expect(page).to have_content(article[:text])
end

Then(/^I should see the new article$/) do
  article = FactoryGirl::attributes_for(:article)
  expect(page).to have_css('h1', text: article[:title])
  expect(page).to have_content(article[:text])
end

Then(/^they should be sorted in reverse order of creation date/) do
  expect(page).to have_content(/Article2.*Article1.*Article0/m)
end

Then(/^I should see the new article content$/) do
  expect(page).to have_css('h1', text: 'Updated title')
  expect(page).to have_content('Updated text')
end

Then(/^I should see the article's category$/) do
  expect(page).to have_link(Category.first.name)
end
