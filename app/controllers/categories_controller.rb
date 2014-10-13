class CategoriesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  
  def index
    @categories = Category.all.sort_alphabetically
  end

  def show
    @category = Category.find(params[:id])
    if signed_in?
      @articles = @category.articles
    else
      @articles = @category.articles.published
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      flash.now[:error] ||= []
      if @category.name.blank?
        flash.now[:error] << 'Name cannot be blank'
      elsif
        flash.now[:error] << 'Category already exists'
      end
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to categories_path
    else
      flash.now[:error] ||= []
      @category.errors.each do |attribute|
        @category.errors[attribute].each do |error| 
          flash.now[:error] << "#{attribute.capitalize} #{error}"
        end
      end

      render :edit
    end
  end

  def destroy
    Category.destroy(params[:id])
    flash[:notice] = 'Category deleted'
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
