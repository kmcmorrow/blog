require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ArticlesHelper. For example:
#
# describe ArticlesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ArticlesHelper, :type => :helper do
  describe "#admin_button" do
    let(:article) { FactoryGirl::create(:draft_article) }

    context "draft article" do
      it "renders the articles/admin_button template correctly" do
        expect(helper).to receive('render').with(partial:
                                                 'articles/admin_button',
                                                 locals: {
                                                   article: article,
                                                   link_text: 'Publish',
                                                   button_style: 'btn-danger'
                                                 })
        helper.admin_button(article)
      end
    end

    context "published article" do
      it "renders the articles/admin_button template correctly" do
        article.published!
        expect(helper).to receive('render').with(partial:
                                                 'articles/admin_button',
                                                 locals: {
                                                   article: article,
                                                   link_text: 'Unpublish',
                                                   button_style: 'btn-success'
                                                 })
        helper.admin_button(article)
      end
    end
  end
end
