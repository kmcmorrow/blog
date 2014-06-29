require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, :type => :helper do
  let(:user) { FactoryGirl.create(:user) }

  describe "sign in user" do
    it "sets the current user" do
      helper.sign_in user
      
      expect(helper.current_user).to eq(user)
    end

    it "sets the remember token" do
      expect { helper.sign_in user }.to change(user, :remember_token)
    end

    it "stores the remember token in the session" do
      helper.sign_in user

      expect(session[:remember_token]).to_not be_blank
    end
  end

  describe "after signing in" do
    before { helper.sign_in user }

    it "is signed_in?" do
      expect(helper).to be_signed_in
    end
  end

  describe "when @current_user is set" do
    before { helper.sign_in user }
    
    describe "current_user" do
      it "returns the the current user" do
        expect(helper.current_user).to eq(user)
      end
    end
  end

  describe "when @current_user is not set" do
    describe "when remember_token is in session" do
      before do
        helper.sign_in user
        helper.current_user = nil
      end
      
      it "returns the user" do
        expect(helper.current_user).to eq(user)
      end
    end

    describe  "when remember_token is not in session" do
      before { session.delete :remember_token }
      
      it "returns nil" do
        expect(helper.current_user).to be_nil
      end
    end
  end
end
