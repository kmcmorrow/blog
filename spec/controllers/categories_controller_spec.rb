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
end
