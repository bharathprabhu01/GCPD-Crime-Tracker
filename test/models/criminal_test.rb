require 'test_helper'

class CriminalTest < ActiveSupport::TestCase
  # Relationship matchers
  should have_many(:suspects)
  should have_many(:investigations).through(:suspects)

  # Validation matchers
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  # Context
  context "Within context" do
    setup do
      create_criminals
    end
    
    teardown do
      destroy_criminals
    end

    should "have an alphabetical scope for ordering" do
      assert_equal [@bane, @catwoman, @maroni, @joker], Criminal.alphabetical.to_a
    end

    should "have a prior_record scope for those convicted of crime" do
      assert_equal [@bane, @catwoman], Criminal.prior_record.to_a.sort_by{|c| c.last_name}
    end

    should "have an enhanced scope for those with enhanced powers" do
      assert_equal [@bane], Criminal.enhanced.to_a
    end

    should "have a search scope that searches names and aliases" do
      assert_equal [@catwoman], Criminal.search("kyle").to_a
      assert_equal [@joker], Criminal.search("jok").to_a
      assert_equal [@joker], Criminal.search("jack").to_a
      assert_equal [@maroni], Criminal.search("sal").to_a
    end

    should "shows name as last, first name" do
      assert_equal "Kyle, Selina", @catwoman.name
    end   
    
    should "shows proper name as first and last name" do
      assert_equal "Selina Kyle", @catwoman.proper_name
    end

    should "not be able remove convicted felons" do
      deny @catwoman.destroy 
    end

    should "not be able remove people with enhanced powers" do
      deny @bane.destroy 
    end

    should "not be able remove current suspects" do
      create_investigations
      create_suspects
      deny @joker.destroy 
      destroy_suspects
      destroy_investigations
    end

    should "be able remove otherwise innocent people" do
      create_investigations
      create_suspects
      assert @maroni.destroy 
      destroy_suspects
      destroy_investigations
    end

  end
end
