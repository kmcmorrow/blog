require 'rails_helper'
include SessionsHelper

RSpec.describe "categories/index.html.erb", :type => :view do
  before { assign(:categories, []) }
  
  describe "when categories exist" do
    before do
      @categories = []
      5.times { |n| @categories << FactoryGirl::create(:category, name: "Category #{n}") }
      assign(:categories, @categories)
    end
    
    it "displays links to each category" do
      render
      5.times do |n|
        expect(rendered).to have_link("Category #{n}", @categories[n])
      end
    end
    
    describe "when logged in" do
      before { sign_in(FactoryGirl::create(:user)) }
      
      it "should show add category link" do
        render
        expect(rendered).to have_link('Add category', new_category_path)
      end

      it "should show edit links for each category" do
        render
        @categories.each do |category|
          expect(rendered).to have_link('Edit', edit_category_path(category.id))
        end
      end
    end

    describe "when not logged in" do
      it "should not show add category link" do
        render
        expect(rendered).to_not have_link('Add category')
      end
    end

    it "should not show edit links" do
        render
        @categories.each do |category|
          expect(rendered).to_not have_link('Edit', edit_category_path(category.id))
        end
      end
  end
end
