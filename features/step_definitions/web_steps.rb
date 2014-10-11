Given(/^I (?:am on|visit) the (.*)$/) do |page|
  case page
  when 'homepage'
    visit "/"
  when 'login page'
    visit '/login'
  when 'new article page'
    visit '/articles/new'
  when 'articles page'
    visit '/articles'
  when 'article page'
    visit article_path(@article)
  when 'edit article page'
    visit edit_article_path(@article)
  when 'categories page'
    visit '/categories'
  when 'search page'
    visit '/search'
  else
    raise "Unknown page: #{page}"
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
  when 'articles page'
    expect(uri.path).to eq(articles_path)
  when 'article page'
    expect(uri.path).to eq(article_path(1))
  when 'edit article page'
    expect(uri.path).to eq(edit_article_path(1))
  when 'categories page'
    expect(uri.path).to eq(categories_path)
  when 'search page'
    expect(uri.path).to eq(search_path)
  else
    raise "Unknown page: #{page}"
  end
end

Then(/^I should see (notice|error): "(.*?)"$/) do |type, message|
  expect(page).to have_css(".alert", text: "#{message}")
end

Then(/^I should( not)? see (?:a|an) "(.*?)" link$/) do |not_see, link|
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

Then(/^I should( not)? see (?:the text )?"(.*?)"$/) do |not_see, content|
  if not_see
    expect(page).not_to have_content(content)
  else
    expect(page).to have_content(content)
  end
end

Then(/^I should see link "(.*?)"$/) do |link|
  expect(page).to have_link(link)
end
