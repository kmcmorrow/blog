require 'rails_helper'
include SessionsHelper

RSpec.describe "categories/index.html.erb", :type => :view do
  before { assign(:categories, []) }
  
  describe "when categories exist" do
    before do
      @categories = []
      5.times { |n| @categories << FactoryGirl::create(:category_with_articles,
                                                       name: "Category #{n}") }
      assign(:categories, @categories)
    end
    
    it "displays links to each category" do
      render
      @categories.each do |category| 
        expect(rendered).to have_link(category.name, category)
      end
    end

    context "with some draft articles" do
      before do
        @categories << FactoryGirl::create(:category, name: 'With Drafts')
        5.times { @categories.last.articles << FactoryGirl::create(:draft_article) }
        assign(:categories, @categories)
      end

      it "shows the number of published articles in each category" do
        render
        @categories.each do |category|
          expect(rendered).to have_selector('span.badge',
                                            text: category.articles.published.size)
        end
      end
    end
    
    describe "when logged in" do
      before { sign_in(FactoryGirl::create(:user)) }
      
      it "should show edit links for each category" do
        render
        @categories.each do |category|
          expect(rendered).to have_link('Edit', edit_category_path(category))
        end
      end

      it "should show delete links for each category" do
        render
        @categories.each do |category|
          expect(rendered).to have_link('Delete', category_path(category))
        end
      end
    end

    describe "when not logged in" do
      it "should not show edit links" do
        render
        @categories.each do |category|
          expect(rendered).to_not have_link('Edit', edit_category_path(category.id))
        end
      end

      it "should not show delete links" do
        render
        @categories.each do |category|
          expect(rendered).to_not have_link('Delete', category_path(category.id))
        end
      end
    end
  end
end
