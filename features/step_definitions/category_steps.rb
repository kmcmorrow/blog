Given(/^there (?:are|is) (#{NUMBER}) categor(?:y|ies)$/) do |num_categories|
  @categories ||= []
  (@categories.length...num_categories).each do |n|
    category = FactoryGirl::create(:category)
    @categories << category
  end
  @category = @categories.first
end

Given(/^there is a category called "(.*)"$/) do |name|
  @categories ||= []
  @categories << FactoryGirl::create(:category, name: name)
end

Given(/^there is an article with (\d+) categor(?:y|ies)$/) do |num_categories|
  step "there are #{num_categories} categories"
  @article = FactoryGirl::create(:article, title: 'Article with categories')
  num_categories.times do |num|
    @article.categories << @categories[num]
  end
end

Given(/^there are (\d+) (published|draft) articles in the first category$/) do |number, status| 
  number.times do
    if status == 'published'
      @categories.first.articles << FactoryGirl::create(:article)
    else
      @categories.first.articles << FactoryGirl::create(:draft_article)
    end
  end
end

When(/^I click on the first category$/) do
  within(:css, '#main') do
    click_link @categories.first.name
  end
end

Then(/^I should see all the categories in alphabetical order$/) do
  category_names = Category.all.map(&:name).sort.join('.*?')
  within(:css, '#main') do
    expect(page.text).to match(category_names)
  end
end

Then(/^I should( not)? see the (published |draft )?articles in the first category$/) do |not_see, status|
  @categories.first.articles.each do |article|
    if !status || article.status == status.strip
      if not_see
        expect(page).not_to have_content(article.title)
      else
        expect(page).to have_content(article.title)
      end
    end
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

Then(/^I should see the category menu$/) do
  within(:css, '#side') do
    Category.all.each do |category|
      expect(page).to have_link(category.name, category_path(category))
    end
  end
end

