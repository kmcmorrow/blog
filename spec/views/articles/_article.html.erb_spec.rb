require 'rails_helper'
include SessionsHelper

RSpec.describe "articles/_article", :type => :view do
  describe "rendering an article" do
    let(:article) { FactoryGirl::create(:article) }
    before { render 'articles/article', article: article }

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

      it "shows an edit link" do
        expect(rendered).to have_link('Edit article', edit_article_path(article))
      end

      it "shows a delete link" do
        expect(rendered).to have_link('Delete article', article_path(article))
      end

      context "when article is published" do
        before { article.published! }
        
        it "shows the published status" do
          expect(rendered).to have_content('PUBLISHED')
        end
        
        it "show a link to unpublish" do
          expect(rendered).to have_link('Unpublish', publish_article_path(article))
        end
      end

      context "when article is a draft" do
        let(:draft_article) { FactoryGirl::create(:draft_article) }
        before { render 'articles/article', article: draft_article }

        it "shows the draft status" do
          expect(rendered).to have_content('DRAFT')
        end
        
        it "shows a link to publish" do
          expect(rendered).to have_link('Publish', publish_article_path(article))
        end
      end
    end

    describe "when not logged in" do
      it "doesn't show an edit link" do
        expect(rendered).not_to have_link('Edit article', edit_article_path(article))
      end

      it "doesn't show a delete link" do
        expect(rendered).not_to have_link('Delete article', article_path(article))
      end

      it "doesn't show the status" do
        expect(rendered).not_to have_content('PUBLISHED')
      end
    end
  end
end
