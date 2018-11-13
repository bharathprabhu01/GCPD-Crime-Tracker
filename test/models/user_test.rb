require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Relationship matchers
  should have_secure_password
  should have_one(:officer)

  # Validation matchers
  should validate_presence_of(:username)
  should validate_uniqueness_of(:username).case_insensitive

  should allow_value("commish").for(:role)
  should allow_value("chief").for(:role)
  should allow_value("officer").for(:role)
  should_not allow_value("bad").for(:role)
  should_not allow_value("hacker").for(:role)
  should_not allow_value(10).for(:role)
  should_not allow_value("leader").for(:role)
  should_not allow_value(nil).for(:role)
  
  
  # Context
  context "Within context" do
    setup do
      create_officer_users
    end
    
    teardown do
      destroy_officer_users
    end

    should "require users to have unique, case-insensitive usernames" do
      # already test on line 8, but doing it long way here
      assert_equal "winston", @winston.username
      # try to switch to Alex's username 'alex'
      @winston.username = "ALEX"
      deny @winston.valid?, "#{@winston.username}"
    end

    should "have make_active and make_inactive methods" do
      assert @winston.active
      @winston.make_inactive
      @winston.reload
      deny @winston.active
      @winston.make_active
      @winston.reload
      assert @winston.active
    end

    should "have role methods and recognize all three roles" do
      karan = FactoryBot.build(:user, username: "karan", role: "officer")
      gordon = FactoryBot.build(:user, username: "jgordon", role: "commish")
      sawyer = FactoryBot.build(:user, username: "msawyer", role: "chief")
      assert karan.role?(:officer)
      deny karan.role?(:chief)
      deny karan.role?(:commish)
      assert gordon.role?(:commish)
      deny gordon.role?(:officer)
      deny gordon.role?(:chief)
      assert sawyer.role?(:chief)
      deny sawyer.role?(:officer)
      deny sawyer.role?(:commish)
    end

    should "allow user to authenticate with password" do
      assert @winston.authenticate("secret")
      deny @winston.authenticate("notsecret")
    end

    should "require a password for new users" do
      bad_user = FactoryBot.build(:user, username: "tank", password: nil)
      deny bad_user.valid?
    end
    
    should "require passwords to be confirmed and matching" do
      bad_user_1 = FactoryBot.build(:user, username: "tank", password: "secret", password_confirmation: nil)
      deny bad_user_1.valid?
      bad_user_2 = FactoryBot.build(:user, username: "tank", password: "secret", password_confirmation: "sauce")
      deny bad_user_2.valid?
    end
    
    should "require passwords to be at least four characters" do
      bad_user = FactoryBot.build(:user, username: "tank", password: "no")
      deny bad_user.valid?
    end

    should "have class method to handle authentication services" do
      assert User.authenticate('winston', 'secret')
      deny User.authenticate('winston', 'notsecret')
    end

  end
end

