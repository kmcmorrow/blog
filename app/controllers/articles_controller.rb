class ArticlesController < ApplicationController
  before_action :require_login, only: [:new, :create]
  
  def index
    @articles = Article.all.order('created_at DESC')
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article created"
      redirect_to :articles
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
  end

  def destroy
    if signed_in?
      Article.delete params[:id]
      redirect_to articles_path, flash: { success: 'Article deleted' }
    else
      redirect_to root_path
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def require_login
    redirect_to login_url unless signed_in?
  end
end
