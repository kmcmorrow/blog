Given(/^the following articles exist$/) do |table|
  table.hashes.each do |article_attributes|
    FactoryGirl::create(:article, article_attributes)
  end
end

When(/^I search for (.*?) then I should see (.*?)$/) do |keyword, titles|
  titles.split(',').map(&:strip).each do |title| 
    expect(page).to have_link(title)
  end
end
