require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    it "assigns the categories" do
      get :index
      expect(assigns(:categories)).to_not be_nil
    end
  end

  describe "GET show" do
    before do
      FactoryGirl::create(:category_with_articles)
    end

    it "assigns the category" do
      get :show, id: 1
      expect(assigns(:category)).to_not be_nil
    end

    it "displays the correct number of articles" do
      get :show, id: 1
      expect(assigns(:category).articles.size).to eq(Category.find(1).articles.count)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "renders the new view" do
      get 'new'
      expect(response).to render_template(:new)
    end

    it "assigns a new category" do
      get 'new'
      expect(assigns(:category)).to_not be_nil
    end
  end
end
