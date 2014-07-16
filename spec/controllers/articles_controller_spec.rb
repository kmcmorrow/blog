require 'rails_helper'
include SessionsHelper

RSpec.describe ArticlesController, :type => :controller do
  describe "GET index" do
    it "renders the correct template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns all articles" do
      FactoryGirl::create(:article)
      get :index
      expect(assigns(:articles).size).to eq(1)
    end
  end
  
  describe "GET show" do
    before do
      article = FactoryGirl.create(:article)
      get :show, id: article
    end
    
    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "assigns the article" do
      expect(assigns(:article)).to be_valid
    end
  end

  describe "when logged in" do
    before { sign_in FactoryGirl::create(:user) }
    
    describe "GET new" do
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
  end

  describe "DELETE destroy" do
    before(:each) do
      @article = FactoryGirl::create(:article)
    end

    describe "when not logged in" do
      it "should not delete the article" do
        expect { delete :destroy, id: @article }.to_not change(Article, :count)
      end

      it "should redirect to the homepage" do
        delete :destroy, id: @article
        expect(response).to redirect_to(root_path)
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
end
