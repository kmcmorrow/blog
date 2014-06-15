Given(/^there (?:are|is) (\d+) published articles?$/) do |num_articles|
  Integer(num_articles).times do |n| 
    FactoryGirl.create(:article, title: "Article#{n}")
  end
end

Then(/^I should see (\d+) articles?$/) do |num_articles|
  Integer(num_articles).times do |n|
    expect(page).to have_css('h2', text: "Article#{n}")
  end
end

Given(/^I (?:am on|visit) the homepage$/) do
  visit "/"
end

When(/^I click "(.*?)"$/) do |link|
  find_link(link).click
end

Then(/^I should be on the (.*)$/) do |page|
  uri = URI.parse(current_url)
  case page
  when 'homepage'
    expect(uri.path).to eq('/')
  when 'login page'
    expect(uri.path).to eq('/login')
  end
end

Given(/^I am on the login page$/) do
  visit '/login'
end

When(/^I fill in valid login details$/) do
  fill_in 'Email', with: 'kevin@example.org'
  fill_in 'Password', with: 'secret'
end

Then(/^I should see "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end
