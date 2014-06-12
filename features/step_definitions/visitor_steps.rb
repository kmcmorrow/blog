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

Then(/^I should be on login page$/) do
  uri = URI.parse(current_url)
  expect(uri.path).to eq('/login')
end
