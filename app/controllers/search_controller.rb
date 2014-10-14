class SearchController < ApplicationController
  def search
    @results = []
    if params[:q]
      @results = Article.published.containing_string(params[:q]).
        page(params[:page]).per(10)
    end
  end
end
