require 'rails_helper'

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

  describe "GET new" do
    it "renders the correct template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new article" do
      get :new
      expect(assigns(:article)).to be_valid
    end
  end

  describe "POST create" do
    it "redirects to the index" do
      post :create
      expect(response).to redirect_to(:index)
    end

    it "creates a new article" do
      expect do
        post :create, article: { title: 'New article', text: 'Some text' }
      end.to change(Article, :count).by(1)
    end
  end
end
