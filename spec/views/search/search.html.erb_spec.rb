require 'rails_helper'

RSpec.describe "search/search.html.erb", :type => :view do
  before { assign(:results,
                  Kaminari.paginate_array([]).page(params[:page]).per(10)) }

  it "shows a search field" do
    render
    expect(rendered).to have_field(:q)
  end

  it "shows a search button" do
    render
    expect(rendered).to have_button('Search')
  end

  context "when no results" do
    describe "when a query was made" do
      before { params[:q] = 'Random' }
      
      it "shows no results message" do
        render
        expect(rendered).to have_content('No results')
      end
    end

    describe "when no query" do
      it "doesn't show the no results message" do
        render
        expect(rendered).not_to have_content('No results')
      end

      it "doesn't show the search terms" do
        render
        expect(rendered).not_to have_content('Search results for:')
      end
    end
  end

  context "when results are found" do
    let(:article) { FactoryGirl::create(:article, title: 'Cat Story') }
    let(:article2) { FactoryGirl::create(:article, title: 'Dog Story')}
    before do
      params[:q] = 'Cat'
      assign(:results, Kaminari.paginate_array([article]).page(params[:page]).per(10))
    end
    
    it "shows search terms used" do
      render
      expect(rendered).to have_content('Search results for: Cat')
    end

    it "shows the article titles" do
      render
      expect(rendered).to have_css('h2', text: article.title)
    end
    
    it "shows the article text (truncated to 300 chars)" do
      long_article = FactoryGirl::create(:article, title: 'Long Cat Story',
                                         text: 'aaaa ' * 100)
      assign(:results, Kaminari.paginate_array([long_article]).page(params[:page]).per(10))
      render
      expect(rendered).to have_css('p', text: /^(aaaa ){58}aaaa\.{3}more$/)
    end

    it "doesn't show non-matching article" do
      render
      expect(rendered).not_to have_css('h2', text: article2.title)
    end
  end
end
