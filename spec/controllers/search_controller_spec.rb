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
      expect(assigns(:results)).to_not be_nil
    end

    context "search for word in title" do
      before do
        @article1 = FactoryGirl::create(:article, title: 'Cats')
        @article2 = FactoryGirl::create(:article, title: 'Dogs')
        @article3 = FactoryGirl::create(:article, title: 'Cats & Dogs')
      end
      
      it "displays correct results" do
        get 'search', q: 'Cats'
        expect(assigns(:results)).to include(@article1, @article3)
      end

      it "doesn't display incorrect results" do
        get 'search', q: 'Cats'
        expect(assigns(:results)).not_to include(@article2)
      end
    end
  end
end
