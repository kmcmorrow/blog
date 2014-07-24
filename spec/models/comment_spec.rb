require 'rails_helper'

RSpec.describe Comment, :type => :model do
  subject { Comment.new }
  it { should respond_to :name }
  it { should respond_to :text }

  describe "validation" do
    describe "has valid name and text" do
      it "should be valid" do
        comment = Comment.new(name: 'Guest', text: 'Hello')
        expect(comment).to be_valid
      end
    end

    describe "has a blank name" do
      it "should not be valid" do
        comment = Comment.new(name: '', text: 'test')
        expect(comment).to_not be_valid
      end
    end

    describe "has a blank text" do
      it "should not be valid" do
        comment = Comment.new(name: 'test', text: '')
        expect(comment).to_not be_valid
      end
    end
  end
end
