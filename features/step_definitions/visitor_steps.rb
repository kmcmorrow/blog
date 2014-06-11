Given(/^I visit the homepage$/) do
  visit "/"
end

Given(/^there (?:are|is) (\d+) published articles?$/) do |num_articles|
  Integer(num_articles).times do |n| 
    FactoryGirl.create(:article, title: "Article#{n}")
  end
end

Then(/^I should see (\d+) articles?$/) do |num_articles|
  Integer(num_articles).times do |n|
    expect(page).to have_selector('h2', text: "Article#{n}")
  end
end
