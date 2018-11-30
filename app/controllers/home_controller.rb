class HomeController < ApplicationController
  def index
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
    redirect_back(fallback_location: home_path) if params[:query].blank?
    @query = params[:query]
    @criminals = Criminal.search(@query)
    @total_hits = @criminals.size
  end
end
