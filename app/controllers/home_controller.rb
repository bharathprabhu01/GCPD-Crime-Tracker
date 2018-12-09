class HomeController < ApplicationController
  def index
    if(logged_in?)
      @most_wanted_criminals =  Criminal.all.sort_by{|c| c.suspects.current.size}.reverse.take(5)
      @longest_open_investigations = Investigation.all.is_open.sort_by{|i| i.date_opened - Date.current}.take(5)
    end
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
