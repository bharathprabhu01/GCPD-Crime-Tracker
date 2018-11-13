module Contexts
  module InvestigationNotes
    def create_investigation_notes
      @lacey_note_1 = FactoryBot.create(:investigation_note, investigation: @lacey, officer: @jblake)
      # because you add notes to closed investigations or by unassigned officers
      @pussyfoot.date_closed = nil
      @pussyfoot.save
      @pussyfoot_jblake.end_date = nil
      @pussyfoot_jblake.save
      @pussyfoot_msawyer.end_date = nil
      @pussyfoot_msawyer.save
      @pussyfoot_note_1 = FactoryBot.create(:investigation_note, investigation: @pussyfoot, officer: @jblake, date: 19.months.ago.to_date, content: "Batman provided some important evidence that implicates Selina Kyle as the culprit.")
      @pussyfoot_note_2 = FactoryBot.create(:investigation_note, investigation: @pussyfoot, officer: @msawyer, date: 18.months.ago.to_date, content: "Batman helped apprehend Selina Kyle as the culprit.")
      @pussyfoot_note_1.update_attribute(:date, 19.months.ago.to_date)
      @pussyfoot_note_2.update_attribute(:date, 18.months.ago.to_date)
      # now reset the close date
      @pussyfoot.date_closed = 18.months.ago.to_date
      @pussyfoot.save   
      @pussyfoot_jblake.end_date = 18.months.ago.to_date
      @pussyfoot_jblake.save
      @pussyfoot_msawyer.end_date = 18.months.ago.to_date
      @pussyfoot_msawyer.save   
    end
    
    def destroy_investigation_notes
      @lacey_note_1.delete
      @pussyfoot_note_1.delete
      @pussyfoot_note_2.delete
    end
  end
end