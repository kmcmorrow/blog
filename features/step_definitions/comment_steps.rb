Given(/^there is an article with a comment$/) do 
  @article = FactoryGirl::create(:article_with_comment)
end

When(/^I delete the comment$/) do
  find_link('Delete', href: article_comment_path(@article.id, @article.comments.first.id)).click
end

When(/^I fill in a comment$/) do
  @comment_name = 'Tester'
  @comment_text = 'Nice article!'
  fill_in 'comment_name', with: @comment_name
  fill_in 'comment_text', with: @comment_text
end

Then(/^I should see my comment$/) do
  expect(page).to have_content(@comment_name)
  expect(page).to have_content(@comment_text)
end

Then(/^I should not see the comment/) do
  comment = FactoryGirl::create(:article_with_comment).comments.first
  expect(page).to_not have_content(comment.name)
  expect(page).to_not have_content(comment.text)
end
