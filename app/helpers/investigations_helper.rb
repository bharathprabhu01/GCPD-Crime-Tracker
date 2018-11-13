module InvestigationsHelper
  def display_date(investigation, state)
    if state == "open"
      display = investigation.date_opened.strftime("%m/%d/%y")
    else
      display = investigation.date_closed.strftime("%m/%d/%y")
    end
    display
  end
end
