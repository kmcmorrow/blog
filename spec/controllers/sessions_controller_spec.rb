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
    let(:user) { FactoryGirl::create(:user) }
    
    describe "with valid details" do
      before do
        post :create, session: { email: user.email,
          password: user.password }
      end
      
      it "should redirect to homepage" do
        expect(response).to redirect_to(:root)
      end

      it "should put remember_token in cookie" do
        expect(cookies[:remember_token]).to_not be_nil
      end

      it "should set flash message" do
        expect(flash[:notice]).to eq('Logged in.')
      end
    end

    describe "with invalid details" do
      before { post :create, session: { email: 'notauser@example.org',
        password: 'badpassword' } }

      it "should render login page" do
        expect(response).to render_template(:new)
      end

      it "should set flash message" do
        expect(flash[:error]).to eq('Invalid login!')
      end
    end
  end
end
