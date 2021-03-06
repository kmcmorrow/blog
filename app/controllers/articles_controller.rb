class ArticlesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  
  def index
    if signed_in?
      articles = Article.all
    else
      articles = Article.published
    end
    @articles = articles.page(params[:page]).per(5)
  end

  def new
    @article = Article.new
  end

  def create
    if params[:article][:categories]
      categories = Category.find(params[:article][:categories].reject(&:empty?))
    else
      categories = []
    end

    @article = Article.new(article_params.merge({ categories: categories }))
    
    if @article.save
      flash[:success] = "Article created"
      redirect_to @article
    else
      flash.now[:error] ||= []
      if @article.title.blank?
        flash.now[:error] << "Title can't be blank"
      end
      if @article.text.blank?
        flash.now[:error] << "Text can't be blank"
      end
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
    redirect_to root_path if @article.draft? and !signed_in?
    @comment = Comment.new(name: 'Guest')
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if params[:article][:categories]
      categories = Category.find(params[:article][:categories].reject(&:empty?))
    else
      categories = @article.categories
    end

    if @article.update_attributes(article_params.merge({ categories: categories}))
      flash[:success] = 'Article updated'
      redirect_to @article
    else
      flash.now[:error] ||= []
      if @article.title.blank?
        flash.now[:error] << "Title can't be blank"
      end
      if @article.text.blank?
        flash.now[:error] << "Text can't be blank"
      end
      render :edit
    end
  end

  def destroy
    Article.delete params[:id]
    redirect_to articles_path, flash: { success: 'Article deleted' }
  end

  def publish
    article = Article.find params[:id]
    if article.published?
      article.draft!
    else
      article.published!
    end
    redirect_to :back
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :status)
  end
end
