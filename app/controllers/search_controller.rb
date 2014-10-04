class SearchController < ApplicationController
  def index
    if search_params.present?
      @query = search_params[:query]
      @results = Post.search_by_body(@query)
      @page = params[:page].to_i || 1
      @posts = @results.page(@page)
    end
  end

  private
  def search_params
    params.permit(:query)
  end
end
