require 'rails_helper'
include SessionsHelper

RSpec.describe "comments/_comment", :type => :view do
  let(:article) { FactoryGirl::create(:article) }
  let(:comment) { FactoryGirl::create(:comment,
                                      article: article,
                                      created_at: Time.new(2014, 01, 30, 14, 30, 20)) }

  
  before do
    render partial: "comments/comment", locals: { comment: comment }
  end
  
  it "displays the commenter name" do
    expect(rendered).to have_selector('h4', text: comment.name)
  end
  
  it "displays the comment date and time" do
    expect(rendered).to have_selector('time', text: '30 January 2014 ~ 14:30')
  end
  
  it "displays the comment text" do
    expect(rendered).to have_content(comment.text)
  end
  
  context "when signed in" do
    before do
      sign_in FactoryGirl::create(:user) 
      render partial: "comments/comment", locals: { comment: comment }
    end
    
    it "displays the delete button" do
      expect(rendered).to have_link('Delete')
    end
  end
end
