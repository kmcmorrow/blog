require 'rails_helper'
include SessionsHelper

RSpec.describe "articles/show", :type => :view do
  let(:article) { FactoryGirl::create(:article_with_comment) }
  let(:comment) { Comment.new(name: 'Guest') }

  before do
    assign(:article, article)
    assign(:comment, comment)
  end

  it "shows the article title" do
    render
    expect(rendered).to have_css('h1', article.title)
  end

  it "shows the article text" do
    render
    expect(rendered).to have_content(article.text)
  end

  describe "the comments section" do
    describe "article comments" do
      it "displays the comment" do
        render
        expect(rendered).to have_content(article.comments.first.name)
        expect(rendered).to have_content(article.comments.first.text)
      end

      describe "when logged in" do
        before { sign_in FactoryGirl::create(:user) }
        
        it "has a delete link" do
          render
          expect(rendered).to have_link('Delete', href: article_comment_path(article.id, article.comments.first.id))
        end
      end

      describe "when not logged in" do
        it "has no delete link" do
          render
          expect(rendered).to_not have_link('Delete')
        end
      end
    end
    
    describe "new comment form" do
      it "shows a name field" do
        render
        expect(rendered).to have_css('input[type=text]', 'Name')
      end
      
      it "shows a text field" do
        render
        expect(rendered).to have_css('textarea', 'Comment')
      end

      it "shows a submit button" do
        render
        expect(rendered).to have_css('input[type=submit]', 'Add Comment')
      end
    end
  end
end
