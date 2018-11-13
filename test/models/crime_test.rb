require 'test_helper'

class CrimeTest < ActiveSupport::TestCase
  # Relationship matchers
  should have_many(:crime_investigations)
  should have_many(:investigations).through(:crime_investigations)

  # Validation matchers
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name).case_insensitive

  # Context
  context "Within context" do
    setup do
      create_crimes
    end
    
    teardown do
      destroy_crimes
    end

    should "have active and inactive scopes" do
      assert_equal 4, Crime.active.count
      assert_equal [@arson, @murder, @robbery, @trespass], Crime.active.to_a.sort_by{|c| c.name}
      assert_equal 1, Crime.inactive.count
      assert_equal [@murder2], Crime.inactive.to_a
    end

    should "have make_active and make_inactive methods" do
      assert @arson.active
      @arson.make_inactive
      @arson.reload
      deny @arson.active
      @arson.make_active
      @arson.reload
      assert @arson.active
    end

    should "have an alphabetical scope for ordering" do
      assert_equal [@arson, @murder, @murder2, @robbery, @trespass], Crime.alphabetical.to_a
    end

    should "have a felonies scope" do
      assert_equal 4, Crime.felonies.count
      assert_equal [@arson, @murder, @murder2, @robbery], Crime.felonies.to_a.sort_by{|c| c.name}
    end

    should "have a misdemeanors scope" do
      assert_equal 1, Crime.misdemeanors.count
      assert_equal [@trespass], Crime.misdemeanors.to_a
    end

    should "never be destroyed" do
      deny @arson.destroy
    end
  end
end
