require 'rails_helper'

RSpec.describe "articles/edit", :type => :view do
  let(:article) { FactoryGirl::create(:article_with_categories) }

  before do
    assign(:article, article)
  end

  describe "the edit form" do
    it "shows the article title" do
      render
      expect(rendered).to have_field('Title', with: article.title)
    end

    it "shows the article text" do
      render
      expect(rendered).to have_css('textarea', text: article.text)
    end

    it "shows the categories list" do
      render
      options = Category.all.map(&:name)
      expect(rendered).to have_select('Categories', with_options: options)
    end

    it "has all article categories selected" do
      render
      selected = article.categories.map(&:name)
      expect(rendered).to have_select('Categories', selected: selected)
    end
  end
end
