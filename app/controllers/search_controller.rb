class SearchController < ApplicationController
  def search
    @results = []
    @results = Article.containing_string(params[:q]) if params[:q]
  end
end
