module Contexts
  module Suspects
    def create_suspects
      @lacey_joker = FactoryBot.create(:suspect, investigation: @lacey, criminal: @joker)
      @pussyfoot_maroni = FactoryBot.create(:suspect, investigation: @pussyfoot, criminal: @maroni, added_on: 20.months.ago.to_date, dropped_on: 19.months.ago.to_date)
      @pussyfoot_catwoman = FactoryBot.create(:suspect, investigation: @pussyfoot, criminal: @catwoman, added_on: 19.months.ago.to_date, dropped_on: nil)
    end
    
    def destroy_suspects
      @lacey_joker.delete
      @pussyfoot_maroni.delete
      @pussyfoot_catwoman.delete
    end
  end
end