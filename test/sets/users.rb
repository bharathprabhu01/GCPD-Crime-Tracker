module Contexts
  module Users
    # Context for both vet and assistant users
    def create_officer_users
      @alex = FactoryBot.create(:user, username: "alex", role: "officer")
      @winston  = FactoryBot.create(:user, username: "winston", role: "officer")
      @stephanie = FactoryBot.create(:user, username: "stephanie", role: "officer")
    end
    
    def destroy_officer_users
      @alex.delete
      @winston.delete
      @stephanie.delete
    end

    def create_leader_users
      @jblake_user  = FactoryBot.create(:user, username: "jblake", role: "officer")
      @jgordon_user = FactoryBot.create(:user, username: "jgordon", role: "commish")
      @msawyer_user = FactoryBot.create(:user, username: "msawyer", role: "chief")
      @jazeveda_user = FactoryBot.create(:user, username: "jazeveda", role: "officer")
    end

    def destroy_leader_users
      @jblake.delete
      @jgordon_user.delete
      @msawyer_user.delete
      @jazeveda_user.delete
    end
  end
end