module Contexts
  module Abilities
    def create_commish_abilities
      @jgordon_user = FactoryBot.create(:user, username: "jgordon", role: "commish")
      @jgordon_ability = Ability.new(@jgordon_user)
    end

    def delete_commish_abilities
      @jgordon_user.delete
    end

    def create_chief_abilities
      @msawyer_user = FactoryBot.create(:user, username: "msawyer", role: "chief")
      @msawyer_ability = Ability.new(@msawyer_user)
      # created related objects for testing
      create_crimes
      create_units
      create_criminals
      # create_leader_users
      @jblake_user  = FactoryBot.create(:user, username: "jblake", role: "officer")
      @jgordon_user = FactoryBot.create(:user, username: "jgordon", role: "commish")
      # @msawyer_user = FactoryBot.create(:user, username: "msawyer", role: "chief")
      @jazeveda_user = FactoryBot.create(:user, username: "jazeveda", role: "officer")
      create_officers
      create_investigations
      create_crime_investigations
      create_assignments
      create_investigation_notes
      create_suspects
    end

    def delete_chief_abilities
      @msawyer_user.delete
    end

    def create_officer_abilities
      @jblake_user = FactoryBot.create(:user, username: "jblake", role: "officer")
      @jblake_ability = Ability.new(@jblake_user)
      # created related objects for testing
      create_crimes
      create_units
      create_criminals
      # create_leader_users
      # @jblake_user  = FactoryBot.create(:user, username: "jblake", role: "officer")
      @jgordon_user = FactoryBot.create(:user, username: "jgordon", role: "commish")
      @msawyer_user = FactoryBot.create(:user, username: "msawyer", role: "chief")
      @jazeveda_user = FactoryBot.create(:user, username: "jazeveda", role: "officer")
      create_officers
      create_investigations
      create_crime_investigations
      create_assignments
      create_investigation_notes
      create_suspects
    end

    def delete_officer_abilities
      @jblake_user.delete
    end

    def create_guest_abilities
      @guest_user = User.new
      @guest_ability = Ability.new(@guest_user)
    end

    def delete_guest_abilities
      # nothing to delete, b/c nothing saved to db
    end

  end
end