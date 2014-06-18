require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
  describe "GET login" do
    it "should be successful" do
      get :new
      expect(response.status).to eq(200)
    end

    it "renders the login template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST create" do
    it "should redirect to homepage" do
      post :create
      expect(response).to redirect_to('/')
    end

    describe "when successful login" do
      
    end
  end
end
