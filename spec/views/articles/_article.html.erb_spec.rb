require 'rails_helper'

RSpec.describe "articles/_article", :type => :view do
  describe "rendering an article" do
    let(:article) { FactoryGirl::create(:article) }

    before { render 'articles/article', article: article }

    it "should show the article title" do
      expect(rendered).to have_css('h2', text: article.title)
    end

    it "should show the article date" do
      expect(rendered).to have_content(article.created_at.strftime('%e %B %Y'))
    end

    it "should show the article text" do
      expect(rendered).to have_content(article.text)
    end
  end
end
