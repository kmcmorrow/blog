require 'rails_helper'

RSpec.describe "Authorizations", :type => :request do
  describe "when logged in" do
    before do
      @user = FactoryGirl::create(:user)
      post sessions_path, session: {
        email: @user.email,
        password: @user.password
      }
    end
    
    describe "ArticlesController" do
      describe "GET index" do
        it "shows the index" do
          get articles_path

          expect(response).to be_success
          expect(response).to render_template(:index)
        end
      end

      describe "GET new" do
        it "shows the new article page" do
          get new_article_path

          expect(response).to be_success
          expect(response).to render_template(:new)
        end
      end

      describe "GET show" do
        before { @article = FactoryGirl::create(:article) }

        it "shows the article page" do
          get article_path(@article.id)

          expect(response).to be_success
          expect(response).to render_template(:show)
        end
      end

      describe "POST create" do
        before { @article = FactoryGirl::build(:article) }
        
        it "creates a new article" do
          expect do
            post articles_path, article: {
              title: @article.title,
              text: @article.text
            }
          end.to change { Article.count }.by(1)
        end

        it "shows the articles page" do
          post articles_path, article: {
            title: @article.title,
            text: @article.text
          }

          expect(response).to redirect_to(article_path(Article.last))
        end
      end
    end
  end

  describe "when not logged in" do
    describe "ArticlesController" do
      describe "GET index" do
        it "shows the index" do
          get articles_path

          expect(response).to be_success
          expect(response).to render_template(:index)
        end
      end

      describe "GET new" do
        it "redirects to the login page" do
          get new_article_path

          expect(response).to redirect_to(login_path)
        end
      end

      describe "GET show" do
        before { @article = FactoryGirl::create(:article) }

        it "shows the article page" do
          get article_path(@article.id)

          expect(response).to be_success
          expect(response).to render_template(:show)
        end
      end

      describe "POST create" do
        before { @article = FactoryGirl::build(:article) }
        
        it "doesn't create a new article" do
          expect do
            post articles_path, article: {
              title: @article.title,
              text: @article.text
            }
          end.to_not change { Article.count }
        end

        it "redirects to the login page" do
          post articles_path, article: {
            title: @article.title,
            text: @article.text
          }

          expect(response).to redirect_to(login_path)
        end
      end
    end
  end
end
