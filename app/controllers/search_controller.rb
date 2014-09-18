class SearchController < ApplicationController
  def search
    @results = Article.containing_string(params[:q]) || []
  end
end
