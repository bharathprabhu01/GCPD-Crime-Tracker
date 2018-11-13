require 'test_helper'

class InvestigationTest < ActiveSupport::TestCase
  # Relationship matchers
  should have_many(:crime_investigations)
  should have_many(:crimes).through(:crime_investigations)
  should have_many(:investigation_notes)
  should have_many(:assignments)
  should have_many(:officers).through(:assignments)
  should have_many(:suspects)
  should have_many(:criminals).through(:suspects)

  # Validation matchers
  should validate_presence_of(:title)
  should validate_presence_of(:date_opened)
  should allow_value(Date.current).for(:date_opened)
  should allow_value(1.day.ago.to_date).for(:date_opened)
  should_not allow_value(1.day.from_now.to_date).for(:date_opened)
  should_not allow_value("bad").for(:date_opened)
  should_not allow_value(2).for(:date_opened)
  should_not allow_value(3.14159).for(:date_opened) 
  should_not allow_value(nil).for(:date_opened)

  # Context
  context "Within context" do
    setup do
      create_crimes
      create_investigations
      create_crime_investigations
    end
    
    teardown do
      destroy_crime_investigations
      destroy_investigations
      destroy_crimes
    end

    should "have an alphabetical scope for ordering" do
      assert_equal [@harbor, @lacey, @pussyfoot], Investigation.alphabetical.to_a
    end

    should "have an chronological scope for ordering" do
      assert_equal [@pussyfoot, @harbor, @lacey], Investigation.chronological.to_a
    end

    should "have an is_open scope to find open cases" do
      assert_equal [@harbor, @lacey], Investigation.is_open.to_a.sort_by{|i| i.date_opened}
    end

    should "have an is_closed scope to find closed cases" do
      assert_equal [@pussyfoot], Investigation.is_closed.to_a
    end

    should "have an open_on_date scope to find open cases for a particular day in the past" do
      assert_equal [@harbor], Investigation.open_on_date(2.weeks.ago).to_a
      assert_equal [@pussyfoot], Investigation.open_on_date(19.months.ago).to_a
    end

    should "have an with_batman scope to find cases Batman helped with" do
      assert_equal [@pussyfoot], Investigation.with_batman.to_a
    end

    should "have an was_solved scope to find solved cases" do
      assert_equal [@pussyfoot], Investigation.was_solved.to_a
    end

    should "have an unsolved scope to find unsolved cases" do
      assert_equal [@harbor, @lacey], Investigation.unsolved.to_a.sort_by{|i| i.date_opened}
    end

    should "have title_search scope to find by title fragment" do
      assert_equal [@harbor], Investigation.title_search('great').to_a
      assert_equal [@lacey], Investigation.title_search('tower').to_a
    end

    should "validate date closed cannot precede date opened but can equal it" do
      assert @pussyfoot.date_opened < @pussyfoot.date_closed
      @pussyfoot.date_closed = 3.years.ago.to_date
      deny @pussyfoot.date_opened < @pussyfoot.date_closed
      deny @pussyfoot.valid?
      @pussyfoot.date_closed = @pussyfoot.date_opened
      assert @pussyfoot.valid?
    end

    should "never be destroyed" do
      deny @pussyfoot.destroy
    end

    should "end assignments of closed investigations" do
      create_units
      create_leader_users
      create_officers
      create_assignments
      assert_equal 1, @harbor.assignments.current.count
      assert_nil @harbor.date_closed
      @harbor.date_closed = Date.current
      @harbor.save
      @harbor.reload
      assert_not_nil @harbor.date_closed
      assert_equal 0, @harbor.assignments.current.count
      destroy_assignments
      destroy_officers
      destroy_leader_users
      destroy_units
    end

    should "not end assignments of investigations are opened but have been edited" do
      create_units
      create_leader_users
      create_officers
      create_assignments
      assert_equal 1, @lacey.assignments.current.count
      @lacey.title = "The Double Killings at Lacey Towers"
      @lacey.save
      @lacey.reload
      assert_equal "The Double Killings at Lacey Towers", @lacey.title
      assert_equal 1, @lacey.assignments.current.count
      destroy_assignments
      destroy_officers
      destroy_leader_users
      destroy_units
    end
  end
end
