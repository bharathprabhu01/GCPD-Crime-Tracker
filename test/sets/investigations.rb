module Contexts
  module Investigations
    def create_investigations
      @lacey     = FactoryBot.create(:investigation)
      @pussyfoot = FactoryBot.create(:investigation, title: "Pussyfoot Heist", description: "Theft of $1.2 million in rare jewels.", crime_location: "2809 West 20th Street", date_opened: 20.months.ago.to_date, date_closed: 18.months.ago.to_date, solved: true, batman_involved: true)
      @harbor    = FactoryBot.create(:investigation, title: "Great Gotham Harbor Arson", description: "The burning of the Gotham Harbor. Over $24 million in property damage done.", crime_location: "Gotham Harbor", date_opened: 2.months.ago.to_date, date_closed: nil)
    end
    
    def destroy_investigations
      @lacey.destroy
      @pussyfoot.destroy
      @harbor.destroy
    end
  end
end