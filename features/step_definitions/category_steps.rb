Given(/^there are (#{NUMBER}) categories$/) do |num_categories|
  num_categories.times do |n|
    FactoryGirl::create(:category,  name: "Category {n}")
  end
end

Given(/^I should see (#{NUMBER}) categories$/) do |num_categories| 
  num_categories.times do |n|
    expect(page).to have_content("Category {n}")
  end
end
