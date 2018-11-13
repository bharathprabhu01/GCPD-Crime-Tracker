require 'test_helper'

class SuspectTest < ActiveSupport::TestCase
  # Relationship matchers
  should belong_to(:investigation)
  should belong_to(:criminal)

  # Validation matchers
  should validate_presence_of(:criminal_id)
  should validate_presence_of(:investigation_id)
  should allow_value(Date.current).for(:added_on)
  should allow_value(1.day.ago.to_date).for(:added_on)
  should_not allow_value(1.day.from_now.to_date).for(:added_on)
  should_not allow_value("bad").for(:added_on)
  should_not allow_value(2).for(:added_on)
  should_not allow_value(3.14159).for(:added_on) 
  should_not allow_value(nil).for(:added_on)  

  # Context
  context "Within context" do
    setup do
      create_criminals
      create_investigations
      create_suspects
    end
    
    teardown do
      destroy_suspects
      destroy_investigations
      destroy_criminals
    end

    should "have an alphabetical scope for ordering" do
      assert_equal [@pussyfoot_catwoman, @pussyfoot_maroni, @lacey_joker], Suspect.alphabetical.to_a
    end

    should "have an chronological scope for ordering" do
      assert_equal [@pussyfoot_maroni, @pussyfoot_catwoman, @lacey_joker], Suspect.chronological.to_a
    end

    should "have a current scope for identifying current suspects" do
      assert_equal [@pussyfoot_catwoman, @lacey_joker], Suspect.current.to_a.sort_by{|s| s.added_on}
    end

    should "validate dropped on date cannot precede added on date but can equal it" do
      assert @pussyfoot_maroni.valid?
      assert @pussyfoot_maroni.added_on < @pussyfoot_maroni.dropped_on
      @pussyfoot_maroni.dropped_on = 3.years.ago.to_date
      deny @pussyfoot_maroni.added_on < @pussyfoot_maroni.dropped_on
      deny @pussyfoot_maroni.valid?
      @pussyfoot_maroni.dropped_on = @pussyfoot_maroni.added_on
      assert @pussyfoot_maroni.valid?
    end
  end

end
