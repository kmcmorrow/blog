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
  describe "sign in user" do
    let(:user) { FactoryGirl.create(:user) }

    before { helper.sign_in user }

    it "signs in the user" do
      expect(helper).to be_signed_in
    end
  end
end
