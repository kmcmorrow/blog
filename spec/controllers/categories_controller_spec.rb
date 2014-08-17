require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    it "assigns the categories" do
      get :index
      expect(assigns(:categories)).to_not be_nil
    end
  end

  describe "GET show" do
    before do
      FactoryGirl::create(:category_with_articles)
    end

    it "assigns the category" do
      get :show, id: 1
      expect(assigns(:category)).to_not be_nil
    end

    it "displays the correct number of articles" do
      get :show, id: 1
      expect(assigns(:category).articles.size).to eq(Category.find(1).articles.count)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "renders the new view" do
      get 'new'
      expect(response).to render_template(:new)
    end

    it "assigns a new category" do
      get 'new'
      expect(assigns(:category)).to_not be_nil
    end
  end

  describe "POST create" do
    it "redirects to categories page" do
      post 'create', category: { name: 'New Category'}
      expect(response).to redirect_to(categories_path)
    end

    it "creates a new category" do
      expect { post 'create', category: { name: 'New Category' } }
        .to change(Category, :count).by(1)
    end

    describe "when no name given" do
      before { post 'create', category: { name: '' } }

      it "renders the new category page" do
        expect(response).to render_template(:new)
      end

      it "has error message" do
        expect(flash[:error]).to include('Name cannot be blank')
      end

      it "doesn't create a new category" do
        expect { post 'create', category: { name: ''} }
          .to_not change(Category, :count)
      end
    end

    describe "when name is not unique" do
      before { @category = FactoryGirl::create(:category) }

      it "doesn't create a new category" do
        expect { post 'create', category: { name: @category.name } }
          .to_not change(Category, :count)
      end

      it "has error message" do
        post 'create', category: { name: @category.name }
        expect(flash[:error]).to include('Category already exists')
      end
    end
  end

  describe "GET edit" do
    before { FactoryGirl::create(:category) }

    it "renders the edit page" do
      get 'edit'
      expect(response).to render_template(:edit)
    end
    
    it "assigns the category" do
      get 'edit'
      expect(assigns(:category)).to_not be_nil
    end
  end
end
