require 'rails_helper'

RSpec.describe "articles/show", :type => :view do
  let(:article) { FactoryGirl::create(:article) }

  before { assign(:article, article) }

  it "shows the article title" do
    render
    expect(rendered).to have_css('h1', article.title)
  end

  it "shows the article text" do
    render
    expect(rendered).to have_content(article.text)
  end

  describe "the comments section" do
    it "shows a name field" do
      render
      expect(rendered).to have_css('input[type=text]', 'Name')
    end
    
    it "shows a text field" do
      render
      expect(rendered).to have_css('textarea', 'Comment')
    end

    it "shows a submit button" do
      render
      expect(rendered).to have_css('input[type=submit]', 'Add Comment')
    end
  end
end
