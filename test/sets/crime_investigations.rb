module Contexts
  module CrimeInvestigations
    def create_crime_investigations
      @lacey_crime_1 = FactoryBot.create(:crime_investigation, investigation: @lacey, crime: @murder)
      # because you can't assign people to closed investigations
      @pussyfoot.date_closed = nil
      @pussyfoot.save
      @pussyfoot_crime_1 = FactoryBot.create(:crime_investigation, investigation: @pussyfoot, crime: @robbery)
      @pussyfoot_crime_2 = FactoryBot.create(:crime_investigation, investigation: @pussyfoot, crime: @trespass)
      # now reset the close date
      @pussyfoot.date_closed = 18.months.ago.to_date
      @pussyfoot.save      
      @harbor_crime_1 = FactoryBot.create(:crime_investigation, investigation: @harbor, crime: @arson)
    end
    
    def destroy_crime_investigations
      @lacey_crime_1.delete
      @pussyfoot_crime_1.delete
      @pussyfoot_crime_2.delete
      @harbor_crime_1.delete
    end
  end
end