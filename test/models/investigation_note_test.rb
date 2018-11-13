require 'test_helper'

class InvestigationNoteTest < ActiveSupport::TestCase
  # Relationship matchers
  should belong_to(:investigation)
  should belong_to(:officer)

  # Validation matchers
  should validate_presence_of(:investigation_id)
  should validate_presence_of(:officer_id)
  should validate_presence_of(:content)

  # Context
  context "Within context" do
    setup do
      create_units
      create_leader_users
      create_officers
      create_investigations
      create_assignments
      create_investigation_notes
    end
    
    teardown do
      destroy_investigation_notes
      destroy_assignments
      destroy_investigations
      destroy_officers
      destroy_leader_users
      destroy_units
    end

    should "have an chronological scope for ordering" do
      assert_equal [@pussyfoot_note_1, @pussyfoot_note_2, @lacey_note_1], InvestigationNote.chronological.to_a
    end

    should "have a by_officer scope for ordering alphabetically by officer" do
      assert_equal [@lacey_note_1, @pussyfoot_note_1, @pussyfoot_note_2], InvestigationNote.by_officer.to_a
    end

    should "have a for_officer scope for retrieving notes by an officer" do
      assert_equal [@pussyfoot_note_2], InvestigationNote.for_officer(@msawyer).to_a
      assert_equal [@pussyfoot_note_1, @lacey_note_1], InvestigationNote.for_officer(@jblake).to_a.sort_by{|n| n.date}
    end

    should "not allow a new note on a closed case" do
      closed_case = FactoryBot.build(:investigation_note, investigation: @pussyfoot, officer: @msawyer)
      deny closed_case.valid?
    end

    should "not allow a note by unassigned officer" do
      not_assigned = FactoryBot.build(:investigation_note, investigation: @lacey, officer: @msawyer)
      deny not_assigned.valid?
    end

    should "set the date of the note to current date" do
      no_date = FactoryBot.create(:investigation_note, date: nil, investigation: @lacey, officer: @jblake)
      no_date.reload
      assert_equal Date.current, no_date.date
    end

  end

end
