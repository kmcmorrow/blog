Given(/^there is an article with a comment$/) do 
  @article = FactoryGirl.create(:article_with_comment)
end

When(/^I delete the comment$/) do
  find_link('Delete', href: 'abc').click
end

Then(/^I should not see the comment/) do
  pending
end
