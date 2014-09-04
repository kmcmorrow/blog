require 'rails_helper'

RSpec.describe "application/_categories_menu", :type => :view do
  it "displays the header" do
    render
    expect(rendered).to have_css('h2', 'Categories')
  end

  it "displays links to every categories" do
    10.times { FactoryGirl::create(:category) }
    render
    Category.all.each do |category|
      expect(rendered).to have_link(category.name, category_path(category))
    end
  end
end
