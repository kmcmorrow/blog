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

      it "should put remember_token in session" do
        expect(session[:remember_token]).to_not be_nil
      end

      it "should set flash message" do
        expect(flash[:notice]).to eq('Logged in.')
      end
    end
    
    describe "with invalid email" do
      before do
        request.env["HTTP_REFERER"] = '/login'
        post :create, session: { email: 'notauser@example.org',
          password: user.password }
      end

      it "should render login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should set flash message" do
        expect(flash[:error]).to eq("User doesn't exist")
      end
    end

    describe "with invalid password" do
      before do
        request.env["HTTP_REFERER"] = '/login'
        post :create, session: { email: user.email,
          password: 'badpassword' }
      end

      it "should render login page" do
        expect(response).to redirect_to(login_path)
      end

      it "should set flash message" do
        expect(flash[:error]).to eq("Invalid password!")
      end
    end
  end

  describe "DELETE destroy" do
    it "should log the user out" do
      # TODO: log in first
      delete :destroy
      
      expect(session[:remember_token]).to be_blank
      expect(assigns(:current_user)).to be_nil
    end

    it "should redirect to homepage" do
      delete :destroy

      expect(response).to redirect_to(root_path)
    end
  end
end
