class HomeController < ApplicationController
  def index
    if(logged_in?)
      # commish dashboard
      @most_wanted_criminals =  Criminal.all.sort_by{|c| c.suspects.current.size}.reverse.take(5)
      @longest_open_investigations = Investigation.all.is_open.sort_by{|i| i.date_opened - Date.current}.take(5)
      @open_cases_with_batman = Investigation.is_open.with_batman
      @top_crimes = Crime.all.active.sort_by{|c| c.crime_investigations.size}.reverse.take(5)
      
      # chief dashboard
      @unit_officers = Officer.for_unit(current_user.officer.unit).active.sort_by{|o| o.investigations.size }
      
      # officer dashboard
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
