require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  before { @article = FactoryGirl::create(:article) }
  
  describe "POST create" do
    describe "with valid name and content" do
      before do
        post :create, article_id: @article.id, comment: {
          name: 'Commenter', text: 'Nice article' }
      end

      it "redirects to the article page" do
        expect(response).to redirect_to(@article)
      end

      it "creates the article" do
        comment = @article.comments.last
        expect(comment.name).to eq('Commenter')
        expect(comment.text).to eq('Nice article')
      end
    end

    describe "with invalid values" do
      before do
        post :create, article_id: @article.id, comment: {
          name: '', text: '' }
      end

      it "redirects to the article page" do
        expect(response).to redirect_to(@article)
      end
      
      it "displays error messages" do
        expect(flash[:error]).to include(/Name can't be blank/)
        expect(flash[:error]).to include(/Comment can't be blank/)
      end
    end
  end
end
