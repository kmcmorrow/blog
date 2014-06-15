require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = User.new(email: "kevin@example.org",
                     password: "secret",
                     password_confirmation: "secret")
  end

  subject { @user }

  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :password_digest }

  describe "when email is not present" do
    before { @user.email = '' }

    it { should_not be_valid }
  end
end
