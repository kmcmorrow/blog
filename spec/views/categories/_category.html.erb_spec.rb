require 'rails_helper'

RSpec.describe "categories/_category.html.erb", :type => :view do
  before { @category = FactoryGirl::create(:category) }
  
  it "shows a link to the category" do
    render "categories/category", category: @category
    expect(rendered).to have_link(@category.name, category_path(@category))
  end

  it "shows the number of articles in the category" do
    4.times { @category.articles << FactoryGirl::create(:article) }
    render "categories/category", category: @category
    expect(rendered).to have_content("(4)")
  end
end
