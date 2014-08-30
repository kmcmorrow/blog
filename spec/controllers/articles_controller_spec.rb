require 'rails_helper'
include SessionsHelper

RSpec.describe ArticlesController, :type => :controller do
  describe "GET index" do
    it "renders the correct template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns at most 5 articles" do
      10.times { FactoryGirl::create(:article) }
      get :index
      expect(assigns(:articles).size).to eq(5)
    end
  end
  
  describe "GET show" do
    before do
      @article = FactoryGirl.create(:article)
      get :show, id: @article
    end
    
    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "assigns the article" do
      expect(assigns(:article)).to be_valid
    end

    describe "article with comments" do
      before { @article.comments.create name: 'Tester', text: 'Nice article' }
      
      it "assigns the comments" do
        expect(assigns(:article).comments).to_not be_empty
      end
    end
  end

  describe "GET new" do
    before { sign_in FactoryGirl::create(:user) }

    it "renders the correct template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new article" do
      get :new
      expect(assigns(:article)).not_to be_nil
    end
  end

  describe "POST create" do
    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }

      describe "when successful" do
        it "redirects to the index" do
          post :create, article: { title: 'New article', text: 'Some text' }
          expect(response).to redirect_to(:articles)
        end

        it "creates a new article" do
          expect do
            post :create, article: { title: 'New article', text: 'Some text' }
          end.to change(Article, :count).by(1)
        end

        describe "when assigning categories" do
          before { 2.times { |n| FactoryGirl::create(:category) } }
          
          it "assigns categories to article" do
            post :create, article: { title: 'New article', text: 'Some text',
              categories: ['1', '2'] }

            expect(Article.first.categories.count).to eq(2)
          end
        end

        it "displays a success message" do
          post :create, article: { title: 'New article', text: 'Some text' }
          expect(flash[:success]).to match("Article created")
        end
      end
      
      describe "when no title" do
        it "displays error message" do
          post :create, article: { text: 'Some text' }
          expect(response).to render_template(:new)
          expect(flash[:error]).to include("Title can't be blank")
        end
      end

      describe "when no text" do
        it "displays error message" do
          post :create, article: { title: 'Some title' }
          expect(response).to render_template(:new)
          expect(flash[:error]).to include("Text can't be blank")
        end
      end
    end

    describe "when not logged in" do
      before { post :create, article: { title: 'Test', text: 'Not logged in' } }
      
      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should display the error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end

      it "should not create the article" do
        expect(Article.count).to eq(0)
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @article = FactoryGirl::create(:article)
    end

    describe "when not logged in" do
      it "should not delete the article" do
        expect { delete :destroy, id: @article }.to_not change(Article, :count)
      end

      it "should redirect to the login page" do
        delete :destroy, id: @article
        expect(response).to redirect_to(login_path)
      end

      it "should display the error message" do
        delete :destroy, id: @article
        expect(flash[:error]).to match('You must be logged in to do that')
      end
    end

    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
      
      it "should delete the article" do
        expect { delete :destroy, id: @article }.to change(Article, :count).by(-1)
      end

      it "should redirect to the articles page" do
        delete :destroy, id: @article
        expect(response).to redirect_to(articles_path)
      end

      it "should show success message" do
        delete :destroy, id: @article
        expect(flash[:success]).to match('Article deleted')
      end
    end
  end

  describe "GET edit" do
    describe "when logged in" do
      before do
        sign_in FactoryGirl::create(:user)
        @article = FactoryGirl::create(:article) 
      end
      
      it "renders the edit page" do
        get :edit, id: @article
        expect(response).to render_template(:edit)
      end

      it "assigns the article" do
        get :edit, id: @article
        expect(assigns(:article)).to eq(@article)
      end
    end

    describe "when not logged in" do
      before do
        @article = FactoryGirl::create(:article)
        get :edit, id: @article
      end
      
      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should display the error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end
    end
  end

  describe "PUT update" do
    before { @article = FactoryGirl::create(:article) }
    
    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
      
      describe "successful update" do
        before do
          put :update, id: @article, article: { title: 'Updated Title',
            text: 'Updated text' } 
        end
        
        it "renders the article view" do
          expect(response).to redirect_to(article_path(@article))
        end

        it "updates the article" do
          updated_article = Article.find(@article.id)
          expect(updated_article.title).to eq('Updated Title')
          expect(updated_article.text).to eq('Updated text')
        end

        it "displays a success message" do
          expect(flash[:success]).to eq('Article updated')
        end
      end

      describe "fail to update" do
        describe "when title is blank" do
          before do 
            put :update, id: @article.id, article: { title: '',
              text: 'Updated text' }
          end
          
          it "renders the edit view" do
            expect(response).to render_template(:edit)
          end

          it "shows an error message" do
            expect(flash[:error]).to include(/Title can't be blank/)
          end
        end

        describe "when text is blank" do
          before do
            put :update, id: @article.id, article: { title: 'Updated Title',
              text: '' }
          end

          it "renders the edit view" do
            expect(response).to render_template(:edit)
          end

          it "shows an error message" do
            expect(flash[:error]).to include(/Text can't be blank/)
          end
        end
      end

      describe "when selecting a category" do
        it "adds the article to the category" do
          @category = FactoryGirl::create(:category)
          put :update, id: @article.id, article: {
            categories: @article.category_ids << @category.id }

          expect(@article.categories).to include(@category)
        end
      end

      describe "when deselecting a category" do
        before do
          @article_with_categories =
            FactoryGirl::create(:article_with_categories)
        end
        
        it "removes the article from the category" do
          expect do
            put :update, id: @article_with_categories.id, article: {
              categories: @article_with_categories.categories[0...-1] }
          end.to change(@article_with_categories.categories, :count).by(-1)
        end
      end
    end

    describe "when not logged in" do
      before do
        put :update, id: @article.id, article: { title: 'Updated Title',
          text: 'Updated text' } 
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "shows an error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end

      it "doesn't change the article" do
        updated_article = Article.find(@article.id)
        expect(updated_article.title).to_not eq('Updated Title')
        expect(updated_article.text).to_not eq('Updated text')
      end
    end
  end
end
