require 'rails_helper'

RSpec.describe Article, :type => :model do
  it { should respond_to :title }
  it { should respond_to :text }
  it { should respond_to :comments }
  it { should respond_to :categories }
  it { should respond_to :status }
  it { should respond_to :draft! }
  it { should respond_to :draft? }
  it { should respond_to :published! }
  it { should respond_to :published? }

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

  describe "#containing_string" do
    context "search titles" do
      let(:article1) { FactoryGirl::create(:article, title: 'Article One') }
      let(:article2) { FactoryGirl::create(:article, title: 'Article Two') }
      let(:article3) { FactoryGirl::create(:article, title: 'Article Three') }
      
      it "should return matching articles" do
        expect(Article.containing_string('One')).to match_array([article1])
      end

      it "should not include non-matching articles" do
        expect(Article.containing_string('One')).not_to match_array([article2, article3])
      end

      it "should return all articles" do
        expect(Article.containing_string('Article')).to match_array([article1, article2, article3])
      end

      it "should return nothing" do
        expect(Article.containing_string('Invalid')).to be_empty
      end
    end
  end

  describe "status" do
    let(:new_article) { Article.new(title: 'Test', text: 'test') }
    it "should be draft by default" do
      expect(new_article).to be_draft
    end

    it "should change to published" do
      new_article.published!
      expect(new_article).to be_published
    end
  end
end
