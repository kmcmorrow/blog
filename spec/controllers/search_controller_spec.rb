require 'rails_helper'

RSpec.describe SearchController, :type => :controller do
  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      expect(response).to be_success
    end

    it "renders the search template" do
      get 'search'
      expect(response).to render_template('search')
    end

    it "assigns the results variable" do
      get 'search'
      expect(assigns(:results)).to be_empty
    end

    describe "search for word in title" do
      let!(:article1) { FactoryGirl::create(:article, title: 'Cats') }
      let!(:article2) { FactoryGirl::create(:article, title: 'Dogs') }
      let!(:article3) { FactoryGirl::create(:article, title: 'Cats & Dogs') }

      it "returns correct results" do
        get 'search', q: 'Cats'
        expect(assigns(:results)).to include(article1, article3)
      end

      it "doesn't return incorrect results" do
        get 'search', q: 'Cats'
        expect(assigns(:results)).not_to include(article2)
      end
    end

    describe "search for word in text" do
      let!(:article1) { FactoryGirl::create(:article,
                                            text: 'Cats have four legs') }
      let!(:article2) { FactoryGirl::create(:article,
                                            text: 'Dogs have four legs') }
      let!(:article3) { FactoryGirl::create(:article,
                                            text: 'I like turtles') }

      it "returns articles with matching word" do
        get 'search', q: 'Dogs'
        expect(assigns(:results)).to include(article2)
      end

      it "returns articles with multiple matching words" do
        get 'search', q: 'have four'
        expect(assigns(:results)).to include(article1, article2)
      end

      it "doesn't return articles with no matching word" do
        get 'search', q: 'have four'
        expect(assigns(:results)).not_to include(article3)
      end
    end

    describe "draft articles" do
      let!(:article) { FactoryGirl::create(:article) }
      let!(:draft_article) { FactoryGirl::create(:draft_article) }

      it "doesn't show draft in search results" do
        get 'search', q: ''
        expect(assigns(:results)).not_to include(draft_article)
      end

      it "only shows 1 result" do
        get 'search', q: ''
        expect(assigns(:results).size).to eq(1)
      end
    end

    describe "pagination" do
      before do
        12.times { FactoryGirl::create(:article) }
      end

      it "returns 10 results" do
        get 'search', q: ''
        expect(assigns(:results).size).to eq(10)
      end

      it "returns the remaining 2 on the next page" do
        get 'search', q: '', page: 2
        expect(assigns(:results).size).to eq(2)
      end
    end
  end
end
