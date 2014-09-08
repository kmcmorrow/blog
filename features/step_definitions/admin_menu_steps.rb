Then(/^I should see the admin menu$/) do
  within(:css, '#side') do
    expect(page).to have_css('h2', text: 'Admin')
  end
end

Then(/^it should contain these links:$/) do |links|
  links.raw.flatten.each do |link|
    within(:css, '#side') do
      expect(page).to have_link(link)
    end
  end
end

Then(/^I should not see the admin menu$/) do
  expect(page.find('#side')).to_not have_css('h2', text: 'Admin')
end
