require 'rails_helper'

RSpec.describe "articles/index", :type => :view do
  describe "with 10 articles" do
    before do
      articles = []
      15.times do |n|
        articles << FactoryGirl::create(:article, title: "Article#{n}")
      end
      assign(:articles, Kaminari.paginate_array(articles).page(params[:page]).per(5))
    end
    
    it "displays the first 5 articles" do
      render
      5.times { |n| expect(rendered).to match(/Article#{n}/) }
    end

    it "doesn't display any more than 5" do
      render
      5.upto(15) { |n| expect(rendered).to_not match(/Article#{n}/) }
    end

    it "shows pagination link for page 2" do
      render
      expect(rendered).to have_link('2', href: "#{articles_path}?page=2")
    end
    
    it "shows pagination link for page 3" do
      render
      expect(rendered).to have_link('3', href: "#{articles_path}?page=3")
    end

    it "shows pagination link for next page" do
      render
      expect(rendered).to have_link('Next', href: "#{articles_path}?page=2")
    end
    
    it "shows pagination link for last page" do
      render
      expect(rendered).to have_link('Last', href: "#{articles_path}?page=3")
    end
  end
end
