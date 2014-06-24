Given(/^there (?:are|is) (\d+) published articles?$/) do |num_articles|
  Integer(num_articles).times do |n| 
    FactoryGirl.create(:article, title: "Article#{n}")
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

When(/^I click "(.*?)"$/) do |link|
  find_link(link).click
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

Then(/^I should see the new article$/) do
  
end

Then(/^I should see (\d+) articles?$/) do |num_articles|
  Integer(num_articles).times do |n|
    expect(page).to have_css('h2', text: "Article#{n}")
  end
end

Then(/^I should be on the (.*)$/) do |page|
  uri = URI.parse(current_url)
  case page
  when 'homepage'
    expect(uri.path).to eq('/')
  when 'login page'
    expect(uri.path).to eq('/login')
  when 'new article page'
    expect(uri.path).to eq(new_article_path)
  end
end

Then(/^I should see (notice|error): "(.*?)"$/) do |type, message|
  expect(page).to have_css(".#{type}", text: "#{message}")
end
