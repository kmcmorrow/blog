require 'rails_helper'

RSpec.describe User, :type => :model do
  before do
    @user = User.new(email: "kevin@example.org",
                     password: "secretpass",
                     password_confirmation: "secretpass")
  end

  subject { @user }

  it { should be_valid }

  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :password_digest }
  it { should respond_to :remember_token }
  it { should respond_to :authenticate }

  describe "when email is not present" do
    before { @user.email = '' }

    it { should_not be_valid }
  end

  describe "when password is too short" do
    before do
      @user.password = 'test123'
      @user.password_confirmation = 'test123'
    end

    it { should_not be_valid }
  end

  describe "when password confirmation doesn't match password" do
    before { @user.password_confirmation = 'wrong' }

    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[userexamplecom user.example.com user@example
        example.com user@example@example.com user@example+example.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@example.com user+test@example.com user@example.ie]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email already exists" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "remember token" do
    before { @user.save }
    it "should not be blank after saving" do
      expect(@user.remember_token).not_to be_blank
    end
  end
end
