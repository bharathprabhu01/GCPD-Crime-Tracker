module Contexts
  module Assignments
    def create_assignments
      @lacey_jblake      = FactoryBot.create(:assignment, investigation: @lacey, officer: @jblake)
      # because you can't assign people to closed investigations
      @pussyfoot.date_closed = nil
      @pussyfoot.save
      @pussyfoot_jblake  = FactoryBot.create(:assignment, investigation: @pussyfoot, officer: @jblake, start_date: 20.months.ago.to_date, end_date: 18.months.ago.to_date)
      @pussyfoot_msawyer = FactoryBot.create(:assignment, investigation: @pussyfoot, officer: @msawyer, start_date: 19.months.ago.to_date, end_date: 18.months.ago.to_date)
      # now reset the close date
      @pussyfoot.date_closed = 18.months.ago.to_date
      @pussyfoot.save
      @harbor_jazeveda   = FactoryBot.create(:assignment, investigation: @harbor, officer: @jazeveda, start_date: 2.months.ago.to_date)
    end
    
    def destroy_assignments
      @lacey_jblake.delete
      @pussyfoot_jblake.delete
      @pussyfoot_msawyer.delete
      @harbor_jazeveda.delete
    end
  end
end