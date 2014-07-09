class ArticlesController < ApplicationController
  before_action :require_login, only: [:new, :create]
  
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    article = Article.new(article_params)
    if article.save
      redirect_to :articles
    else
      render :new
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :text)
  end

  def require_login
    redirect_to login_url unless signed_in?
  end
end
