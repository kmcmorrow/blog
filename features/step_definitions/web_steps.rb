Given(/^there (?:are|is) (\d+) published articles?$/) do |num_articles|
  Integer(num_articles).times do |n| 
    @articles = FactoryGirl.create(:article, title: "Article#{n}")
  end
end

Given(/^I (?:am on|visit) (.*)$/) do |page|
  case page
  when 'the homepage'
    visit "/"
  when 'the login page'
    visit '/login'
  when 'the new article page'
    visit '/articles/new'
  when 'the articles page'
    visit '/articles'
  when 'the article page'
    visit '/articles/1'
  else
    raise 'Unknown page'
  end
end

Given(/^I have an account$/) do
  user = FactoryGirl::create(:user)
end

Given(/^I am logged in$/) do
  FactoryGirl::create(:user)
  visit '/login'
  step "I fill in valid login details"
end

Given(/^I log out$/) do
  click_link 'Log out'
end

When(/^I click on the article title$/) do
  step 'I click "Article0"'
end

When(/^I click "(.*?)"$/) do |link|
  click_link link
end

When(/^I fill in valid login details$/) do
  user = FactoryGirl::attributes_for(:user)
  fill_in 'Email', with: user[:email]
  fill_in 'Password', with: user[:password]
  click_button 'Log in'
end

When(/^I fill in the wrong password$/) do
  user = FactoryGirl::attributes_for(:user)
  fill_in 'Email', with: user[:email]
  fill_in 'Password', with: 'wrongpassword'
  click_button 'Log in'
end

When(/^I fill in the wrong email$/) do
  fill_in 'Email', with: 'wrong@email.com'
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

When(/^I add a new article$/) do
  article = FactoryGirl::attributes_for(:article)
  fill_in 'Title', with: article[:title]
  fill_in 'Text', with: article[:text]
  click_button 'Add article'
end

Then(/^I should see (\d+) article(?:s)?$/) do |num_articles|
  Integer(num_articles).times do |n|
    expect(page).to have_css('h2', text: "Article#{n}")
  end
end

Then(/^I should see the article$/) do
  article = FactoryGirl::attributes_for(:article)
  expect(page).to have_css('h1', text: 'Article0')
  expect(page).to have_content(article[:text])
end


Then(/^I should see the new article$/) do
  article = FactoryGirl::attributes_for(:article)
  expect(page).to have_css('h2', text: article[:title])
  expect(page).to have_content(article[:text])
end

Then(/^I should be on the (.*)$/) do |page|
  uri = URI.parse(current_url)
  case page
  when 'homepage'
    expect(uri.path).to eq(root_path)
  when 'login page'
    expect(uri.path).to eq(login_path)
  when 'new article page'
    expect(uri.path).to eq(new_article_path)
  when 'article page'
    expect(uri.path).to eq(article_path(1))
  end
end

Then(/^I should see (notice|error): "(.*?)"$/) do |type, message|
  expect(page).to have_css(".alert", text: "#{message}")
end

Then(/^I should( not)? see a "(.*?)" link$/) do |not_see, link|
  if not_see
    expect(page).to_not have_link(link)
  else
    expect(page).to have_link(link)
  end
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^they should be sorted in reverse order of creation date/) do
  expect(page).to have_content(/Article2.*Article1.*Article0/m)
end
