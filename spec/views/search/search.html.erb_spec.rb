require 'rails_helper'

RSpec.describe "search/search.html.erb", :type => :view do
  before { assign(:results, []) }

  it "shows a search field" do
    render
    expect(rendered).to have_field(:q)
  end

  it "shows a search button" do
    render
    expect(rendered).to have_button('Search')
  end

  context "when no results" do
    it "shows no results message" do
      render
      expect(rendered).to have_content('No results')
    end
  end

  context "when results are found" do
    let(:article) { FactoryGirl::create(:article, title: 'Cat Story') }
    before do
      params[:q] = 'Cat'
      assign(:results, [article])
    end
    
    it "shows search terms used" do
      render
      expect(rendered).to have_content('Search results for: Cat')
    end

    it "shows the article titles" do
      render
      expect(rendered).to have_css('h2', article.title)
    end
    
    it "shows the article text" do
      render
      expect(rendered).to have_css('p', article.text)
    end
  end
end
