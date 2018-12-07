class HomeController < ApplicationController
  def index
    # commish dashboard
    @most_wanted_criminals =  Criminal.all.sort_by{|c| c.suspects.current.size}.reverse.take(5)
    @longest_open_investigations = Investigation.all.is_open.sort_by{|i| i.date_opened - Date.current}.take(5)
    @open_cases_with_batman = Investigation.is_open.with_batman
  end

  def about
  end

  def contact
  end

  def privacy
  end

  def search
  end
end
