Given(/^I (?:am on|visit) (.*)$/) do |page|
  case page
  when 'the homepage'
    visit "/"
  when 'the login page'
    visit '/login'
  when 'the new article page'
    visit '/articles/new'
  when 'the articles page'
    visit '/articles'
  when 'the article page'
    visit article_path(@article)
  when 'the edit article page'
    visit edit_article_path(@article)
  when 'the categories page'
    visit '/categories'
  when 'the search page'
    visit '/search'
  else
    raise 'Unknown page'
  end
end

When(/^I click "(.*?)"$/) do |link|
  click_link link
end

When(/^I (?:click|press) the "(.*?)" (link|button)/) do |name, thing|
  if thing == 'link'
    click_link name
  elsif thing == 'button'
    click_button name
  end
end

Then(/^I should be on the (.*)$/) do |page|
  uri = URI.parse(current_url)
  case page
  when 'homepage'
    expect(uri.path).to eq(root_path)
  when 'login page'
    expect(uri.path).to eq(login_path)
  when 'new article page'
    expect(uri.path).to eq(new_article_path)
  when 'article page'
    expect(uri.path).to eq(article_path(1))
  end
end

Then(/^I should see (notice|error): "(.*?)"$/) do |type, message|
  expect(page).to have_css(".alert", text: "#{message}")
end

Then(/^I should( not)? see a "(.*?)" link$/) do |not_see, link|
  if not_see
    expect(page).to_not have_link(link)
  else
    expect(page).to have_link(link)
  end
end

Then(/^show me the page$/) do
  save_and_open_page
end

Then(/^I should see the message: "(.*?)"$/) do |message|
  expect(page).to have_content(message)  
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Then(/^I should see link "(.*?)"$/) do |link|
  expect(page).to have_link(link)
end
