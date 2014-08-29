Given(/^I have an account$/) do
  user = FactoryGirl::create(:user)
end

Given(/^I am logged in$/) do
  FactoryGirl::create(:user)
  visit '/login'
  step "I fill in valid login details"
end

Given(/^I log out$/) do
  click_link 'Log out'
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
