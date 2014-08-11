require 'rails_helper'

RSpec.describe "categories/index.html.erb", :type => :view do
  describe "when categories exist" do
    before do
      @categories = []
      5.times { |n| @categories << FactoryGirl::create(:category, name: "Category {n}") }
      assign(:categories, @categories)
    end
    
    it "displays links to each category" do
      render
      5.times { |n| expect(rendered).to have_link("Category {n}", @categories[n]) }
    end
  end
end
