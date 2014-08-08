Given(/^there are (#{NUMBER}) categories$/) do |num_categories|
  num_categories.times do |n|
    FactoryGirl::create(:category,  name: "Category #{n}")
  end
end

Then(/^I should see (#{NUMBER}) categories$/) do |num_categories| 
  num_categories.times do |n|
    expect(page).to have_content("Category #{n}")
  end
end

When(/^I click on a category$/) do
  click_link 'Category 0'
end

Then(/^I should see the articles in that category$/) do
  pending
end
