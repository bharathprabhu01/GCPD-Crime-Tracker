require 'test_helper'

class CrimeInvestigationTest < ActiveSupport::TestCase
  # Relationship matchers
  should belong_to(:investigation)
  should belong_to(:crime)

  # Validation matchers
  should validate_presence_of(:investigation_id)
  should validate_presence_of(:crime_id)

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

    should "have a scope for_crime passing in crime_id" do
      assert_equal [@lacey], CrimeInvestigation.for_crime(@murder.id).map{|ci| ci.investigation }
    end

    should "have a scope for_investigation passing in investigation_id" do
      assert_equal [@murder], CrimeInvestigation.for_investigation(@lacey.id).map{|ci| ci.crime }
      assert_equal 2, CrimeInvestigation.for_investigation(@pussyfoot.id).count
    end

    should "identify a non-active crime as invalid" do
      bad_crime = FactoryBot.build(:crime_investigation, investigation: @lacey, crime: @murder2)
      deny bad_crime.valid?
    end

    should "identify a closed case as invalid" do
      closed_investigation = FactoryBot.build(:crime_investigation, investigation: @pussyfoot, crime: @murder)
      deny closed_investigation.valid?
    end
  end
end
