require 'rails_helper'

RSpec.describe "categories/show", :type => :view do
  describe "when articles exist" do
    before do
      assign(:category, FactoryGirl::create(:category_with_articles))
      assign(:articles, Kaminari.paginate_array([FactoryGirl::create(:article)]).page(1).per(5))
    end

    it "renders the article partial" do
      render
      expect(view).to render_template(partial: 'articles/_article')
    end
  end
end
