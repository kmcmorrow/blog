require 'rails_helper'

RSpec.describe "articles/_admin_button", :type => :view do
  let(:article) { FactoryGirl::create(:article) }
  before do
    render partial: 'articles/admin_button', locals: {
      link_text: 'Publish',
      button_style: 'btn-danger',
      article: article }
  end
  
  it "shows an edit link" do
    expect(rendered).to have_link('Edit article', edit_article_path(article))
  end

  it "shows a delete link" do
    expect(rendered).to have_link('Delete article', article_path(article))
  end

  it "shows a publish/unpublish link" do
    expect(rendered).to have_link('Publish', publish_article_path(article))
  end
end
