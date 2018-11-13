require 'test_helper'

class AssignmentTest < ActiveSupport::TestCase
  # Relationship matchers
  should belong_to(:officer)
  should belong_to(:investigation)

  # Validation matchers
  should validate_presence_of(:officer_id)
  should validate_presence_of(:investigation_id)
  should validate_presence_of(:start_date)
  should allow_value(Date.current).for(:start_date)
  should allow_value(1.day.ago.to_date).for(:start_date)
  should_not allow_value(1.day.from_now.to_date).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(2).for(:start_date)
  should_not allow_value(3.14159).for(:start_date) 
  should_not allow_value(nil).for(:start_date)

  # Context
  context "Within context" do
    setup do
      create_units
      create_leader_users
      create_officers
      create_investigations
      create_assignments
    end
    
    teardown do
      destroy_assignments
      destroy_investigations
      destroy_officers
      destroy_leader_users
      destroy_units
    end

    # test the scope 'current'
    should "show that there are two assignments that are current" do
      assert_equal [@harbor_jazeveda, @lacey_jblake], Assignment.current.to_a.sort_by{|a| a.start_date}
    end    
    
    should "show that there are two assignments that are past" do
      assert_equal [@pussyfoot_jblake, @pussyfoot_msawyer], Assignment.past.to_a.sort_by{|a| a.start_date}
    end

    # test the scope 'current'
    should "order assignments chronologically by start date" do
      assert_equal [@pussyfoot_jblake, @pussyfoot_msawyer, @harbor_jazeveda, @lacey_jblake], Assignment.chronological.to_a
    end

    should "order assignments alphabetically by officer name" do
      assert_equal [@harbor_jazeveda, @lacey_jblake, @pussyfoot_jblake, @pussyfoot_msawyer], Assignment.by_officer.to_a
    end

    should "identify a non-active officer as an invalid assignment" do
      bad_assignment_officer = FactoryBot.build(:assignment, investigation: @harbor, officer: @gloeb)
      deny bad_assignment_officer.valid?

    end

    should "identify a closed case as an invalid assignment" do
      bad_assignment_case = FactoryBot.build(:assignment, investigation: @pussyfoot, officer: @jgordon)
      deny bad_assignment_case.valid?
    end

    should "validate end date cannot precede start date but can equal it" do
      assert @pussyfoot_jblake.valid?
      assert @pussyfoot_jblake.start_date < @pussyfoot_jblake.end_date
      @pussyfoot_jblake.end_date = 3.years.ago.to_date
      deny @pussyfoot_jblake.start_date < @pussyfoot_jblake.end_date
      deny @pussyfoot_jblake.valid?
      @pussyfoot_jblake.end_date = @pussyfoot_jblake.start_date
      assert @pussyfoot_jblake.valid?
    end

    should "not allow duplicate assignments" do
      duplicate_assignment = FactoryBot.build(:assignment, investigation: @harbor, officer: @jazeveda)
      deny duplicate_assignment.valid?
    end

    should "allow reassignment of officer to an investigation" do
      @harbor_jazeveda.end_date = 2.weeks.ago.to_date
      @harbor_jazeveda.save
      @harbor_jazeveda.reload
      reassignment = FactoryBot.build(:assignment, investigation: @harbor, officer: @jazeveda)
      assert reassignment.valid?
    end

    should "never be destroyed" do
      deny @pussyfoot_jblake.destroy
    end
  end
end
