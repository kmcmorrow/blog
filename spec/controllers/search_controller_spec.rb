require 'rails_helper'

RSpec.describe SearchController, :type => :controller do

  describe "GET 'search'" do
    context "without query" do
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
    end
    
    context "with query" do
      before do
        FactoryGirl::create(:article, title: 'Cats')
        FactoryGirl::create(:article, title: 'Dogs')
        FactoryGirl::create(:article, title: 'Cats & Dogs')
      end
      
      it "displays correct results" do
        get 'search', q: 'Cats'
        expect(response).to have_link('Cats')
        expect(response).to have_link('Cats & Dogs')
      end

      it "doesn't display incorrect results" do
        get 'search', q: 'Cats'
        expect(reponse).not_to have_link('Dogs')
      end
    end
  end

end
