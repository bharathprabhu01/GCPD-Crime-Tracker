require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # Relationship matchers
  should have_many(:officers)
  should have_many(:assignments).through(:officers)

  # Validation matchers
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

  # Context
  context "Within context" do
    setup do
      create_units
    end
    
    teardown do
      destroy_units
    end

    should "have active and inactive scopes" do
      assert_equal 3, Unit.active.count
      assert_equal [@headquarters, @homicide, @major_crimes], Unit.active.to_a.sort_by{|u| u.name}
      assert_equal 1, Unit.inactive.count
      assert_equal [@section_31], Unit.inactive.to_a
    end

    should "have make_active and make_inactive methods" do
      assert @major_crimes.active
      @major_crimes.make_inactive
      @major_crimes.reload
      deny @major_crimes.active
      @major_crimes.make_active
      @major_crimes.reload
      assert @major_crimes.active
    end

    should "have an alphabetical scope for ordering" do
      assert_equal [@headquarters, @homicide, @major_crimes, @section_31], Unit.alphabetical.to_a
    end

    should "be able to calculate the number of active officers in the unit" do
      create_leader_users
      create_officers
      assert_equal 3, @major_crimes.number_of_active_officers
      # doesn't get Loeb in HQ, who is inactive...
      assert_equal 1, @headquarters.number_of_active_officers
      destroy_officers
      destroy_leader_users
    end

    should "be able to calculate the number of open investigations the unit is part of" do
      create_leader_users
      create_officers
      create_investigations
      create_assignments
      # doesn't include the closed cases, like Pussyfoot
      assert_equal 2, @major_crimes.number_of_unique_open_investigations
      # now add Blake to harbor case; count should not go up
      assert_equal 1, @harbor.assignments.count
      harbor_jblake      = FactoryBot.create(:assignment, investigation: @harbor, officer: @jblake)
      @harbor.reload
      assert_equal 2, @harbor.assignments.count
      @major_crimes.reload  # to be sure...
      assert_equal 2, @major_crimes.number_of_unique_open_investigations
      destroy_assignments
      destroy_investigations
      destroy_officers
      destroy_leader_users
    end

    should "not be able destroy units with officers assigned" do
      create_leader_users
      create_officers
      deny @major_crimes.destroy  
      destroy_officers
      destroy_leader_users
    end

    should "be able destroy units without officers assigned" do
      create_leader_users
      create_officers
      assert @homicide.destroy
      destroy_officers
      destroy_leader_users
    end
  end

end
