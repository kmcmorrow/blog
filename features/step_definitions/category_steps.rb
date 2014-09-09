Given(/^there (?:are|is) (#{NUMBER}) categor(?:y|ies)$/) do |num_categories|
  @categories ||= []
  (@categories.length...num_categories).each do |n|
    category = FactoryGirl::create(:category)
    @categories << category
  end
  @category = @categories.first
end

Given(/^there is an article with (\d+) categor(?:y|ies)$/) do |num_categories|
  step "there are #{num_categories} categories"
  @article = FactoryGirl::create(:article, title: 'Article with categories')
  num_categories.times do |num|
    @article.categories << @categories[num]
  end
end

When(/^I click on a category$/) do
  within(:css, '#main') do
    click_link @categories.first.name
  end
end

Then(/^I should see all the categories$/) do
  Category.all.each do |category|
    within(:css, '#main') do
      expect(page).to have_link(category.name, category_path(category))
    end
  end
end

Then(/^I should see the articles in that category$/) do
  @categories.first.articles.each do |article|
    expect(page).to have_content(article.title)
    expect(page).to have_content(article.text)
  end
end

Then(/^I should see links to the categories$/) do
  within(:css, '#main') do
    @article.categories.each do |category|
      expect(page).to have_link(category.name)
    end
  end
end

When(/^I create a new category with an existing name$/) do
  FactoryGirl::create(:category, name: 'New Category Name')
  step 'I create a new category'
end

When(/^I create a new category$/) do
  click_link 'New Category'
  fill_in 'Name', with: 'New Category Name'
  click_button 'Create Category'
end

Then(/^I should see the new category$/) do
  within(:css, '#main') do
    expect(page).to have_link('New Category Name', category_path(Category.last))
  end
end

When(/^I change the category name$/) do
  fill_in 'Name', with: 'New Name'
  click_button 'Update Category'
end

Then(/^I should see the new category name$/) do
  within(:css, '#main') do
    expect(page).to have_content('New Name')
  end
end

Then(/^there should be (\d+) categor(?:y|ies)$/) do |number|
  expect(Category.count).to eq(number)
end

Then(/^I should not see the category name$/) do
  within(:css, '#main') do
    expect(page).to_not have_content(FactoryGirl::attributes_for(:category)[:name])
    end
end

When(/^I select the category$/) do
  select @category.name
end

When(/^I unselect the first category$/) do
  @removed_category = @categories.first
  unselect @removed_category.name
end

Then(/^I should see the category link$/) do
  within(:css, '#main') do
    expect(page).to have_link(@category.name, category_path(@category))
  end
end

Then(/^I should only see a link to the other category$/) do
  within(:css, '#main') do
    expect(page).to_not have_link(@removed_category.name,
                                  category_path(@removed_category))
    expect(page).to have_link(@categories.last.name,
                              category_path(@categories.last))
  end
end
