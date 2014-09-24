Given(/^the following articles exist$/) do |table|
  table.hashes.each do |article_attributes|
    FactoryGirl::create(:article, article_attributes)
  end
end

When(/^I search for "(.*?)"$/) do |keyword|
  fill_in 'q', with: keyword
  click_button 'Search'
end
