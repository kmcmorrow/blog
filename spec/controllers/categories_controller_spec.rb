require 'rails_helper'
include SessionsHelper

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
    let(:category) { FactoryGirl::create(:category) }

    before do
      2.times { category.articles << FactoryGirl::create(:article) }
      2.times { category.articles << FactoryGirl::create(:draft_article) }
    end

    it "assigns the category" do
      get :show, id: category.id
      expect(assigns(:category)).to_not be_nil
    end

    it "assigns the articles" do
      get :show, id: category.id
      expect(assigns(:articles)).to_not be_nil
    end

    it "shows two articles" do
      get :show, id: category.id
      expect(assigns(:articles).size).to eq(2)
    end

    context "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
      
      it "shows 4 articles" do
        get :show, id: category.id
        expect(assigns(:articles).size).to eq(4)
      end
    end

    it "shows newest articles first" do
      category.articles =
        [FactoryGirl::create(:article, title: 'Older',
                             created_at: Date.new(2013, 01, 01)),
         FactoryGirl::create(:article, title: 'Newer',
                             created_at: Date.new(2014, 01, 01))]
      get :show, id: category.id
      expect(assigns(:articles).first.title).to eq('Newer')
      expect(assigns(:articles).last.title).to eq('Older')
    end

    it "shows 5 articles per page" do
      articles = []
      6.times { articles << FactoryGirl::create(:article) }
      category.articles = articles

      get :show, id: category.id
      expect(assigns(:articles).size).to eq(5)
    end
  end

  describe "GET new" do
    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
    
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

    describe "when not logged in" do
      before { get 'new' }
      
      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "displays the error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end
    end
  end

  describe "POST create" do
    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
      
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
    
    describe "when not logged in" do
      before { get 'new' }
      
      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "displays the error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end
    end
  end

  describe "GET edit" do
    before { @category = FactoryGirl::create(:category) }
    
    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
      
      it "renders the edit page" do
        get 'edit', id: @category
        expect(response).to render_template(:edit)
      end
      
      it "assigns the category" do
        get 'edit', id: @category
        expect(assigns(:category)).to eq(@category)
      end
    end
  
    describe "when not logged in" do
      before { get 'edit', id: @category }
      
      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "displays the error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end
    end
  end

  describe "PUT update" do
    before { @category = FactoryGirl::create(:category) }

    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
      
      describe "when successful update" do
        before { put 'update', id: @category, category: { name: 'New Name' } }

        it "redirects to the categories page" do
          expect(response).to redirect_to(categories_path)
        end

        it "updates the category name" do
          expect(@category.reload.name).to eq('New Name')
        end
      end
      
      describe "when new name is blank" do
        before { put 'update', id: @category, category: { name: '' } }
        
        it "renders the edit page" do
          expect(response).to render_template(:edit)
        end
        
        it "shows error message" do
          expect(flash[:error]).to include("Name can't be blank")
        end
      end

      describe "when new name is taken" do
        before do
          existing_category = FactoryGirl::create(:category, name: 'Existing')
          put 'update', id: @category, category: { name: existing_category.name }
        end
        
        it "renders the edit page" do
          expect(response).to render_template(:edit)
        end
        
        it "shows error message" do
          expect(flash[:error]).to include('Name has already been taken')
        end
      end
    end
  
    describe "when not logged in" do
      before { put 'update', id: @category, category: { name: 'New Name' } }
      
      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "displays the error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end
    end
  end

  describe "DELETE destroy" do
    before { @category = FactoryGirl::create(:category) }

    describe "when logged in" do
      before { sign_in FactoryGirl::create(:user) }
      
      it "redirects to the categories page" do
        delete 'destroy', id: @category
        expect(response).to redirect_to(categories_path)
      end

      it "deletes the category" do
        expect do
          delete 'destroy', id: @category
        end.to change(Category, :count).by(-1)
      end

      it "shows success message" do
        delete 'destroy', id: @category
        expect(flash[:notice]).to match('Category deleted')
      end
    end
    
    describe "when not logged in" do
      before { delete 'destroy', id: @category }
      
      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end

      it "displays the error message" do
        expect(flash[:error]).to match('You must be logged in to do that')
      end
    end
  end
end
