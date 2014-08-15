class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
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

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
