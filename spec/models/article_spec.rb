require 'rails_helper'

RSpec.describe Article, :type => :model do
  subject { Article.new }
  it { should respond_to :title }
  it { should respond_to :text }
  it { should respond_to :comments }
  it { should respond_to :categories }

  describe "with valid title and text" do
    it "should be valid" do
      article = Article.create(title: 'Hello', text: 'Hello World!')
      expect(article).to be_valid
    end
  end

  describe "with no title" do
    it "should not be valid" do
      article = Article.create(text: 'Hello World!')
      expect(article).to_not be_valid
    end
  end

  describe "with no text" do
    it "should not be valid" do
      article = Article.create(title: 'Hello')
      expect(article).to_not be_valid
    end
  end
end
