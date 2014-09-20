class SearchController < ApplicationController
  def search
    @results = params[:q] ? Article.containing_string(params[:q]) : []
  end
end
