require 'rails_helper'
include SessionsHelper

RSpec.describe "articles/_article", :type => :view do
  describe "rendering an article" do
    let(:article) { FactoryGirl::create(:article) }

    before do
      controller.singleton_class.class_eval do
        protected
        def admin_button(article)
          'article_admin_menu'
        end
        helper_method :admin_button
      end
      render 'articles/article', article: article
    end

    it "should show the article title" do
      expect(rendered).to have_css('h1', text: article.title)
    end

    it "should show the article date" do
      expect(rendered).to have_content(article.created_at.strftime('%e %B %Y'))
    end

    it "should show the article text" do
      expect(rendered).to have_content(article.text)
    end

    describe "with categories" do
      before do
        article.categories << FactoryGirl::create(:category)
        render 'articles/article', article: article
      end
      
      it "shows the articles categories" do
        article.categories.each do |category|
          expect(rendered).to have_link(category.name, href: category_path(category))
        end
      end
    end

    describe "when logged in" do
      before do
        sign_in FactoryGirl::create(:user)
        render 'articles/article', article: article
      end

      it "calls the admin_button helper" do
        expect(rendered).to have_content('article_admin_menu')
      end
    end

    describe "when not logged in" do
      it "doesn't call the admin_button helper" do
        expect(rendered).not_to have_content('article_admin_menu')
      end
    end
  end
end
