Given(/^the following articles exist$/) do |table|
  table.hashes.each do |article_attributes|
    FactoryGirl::create(:article, article_attributes)
  end
end

When(/^I search for "(.*?)"$/) do |keyword|
  within('#main') do
    fill_in 'q', with: keyword
    click_button 'Search'
  end
end

When(/^I search for the draft article$/) do
  within('#main') do
    fill_in 'q', with: 'Draft'
    click_button 'Search'
  end
end

When(/^I search for a word in the sidebar$/) do
  within('#side') do
    fill_in 'q', with: 'Hello'
    click_button 'Search'
  end
end

Then(/^I should see the search box$/) do
  within('#side') do
    expect(page).to have_css('#search-form')
  end
end
