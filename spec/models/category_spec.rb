require 'rails_helper'

RSpec.describe Category, :type => :model do
  subject { Category.new }
  it { should respond_to :name }
  it { should respond_to :articles }

  describe "with a valid name" do
    it "should be valid" do
      category = Category.create(name: 'Default')
      expect(category).to be_valid
    end
  end

  describe "with no name" do
    it "should not be valid" do
      category = Category.create
      expect(category).to_not be_valid
    end
  end

  describe "with duplicate name" do
    before { FactoryGirl::create(:category) }

    it "should not be valid" do
      category = Category.create(name: FactoryGirl::attributes_for(:category)[:name])
      expect(category).to_not be_valid
    end
  end
end
