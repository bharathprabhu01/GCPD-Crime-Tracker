module Contexts
  module Criminals
    def create_criminals
      @joker    = FactoryBot.create(:criminal)
      @catwoman = FactoryBot.create(:criminal, first_name: "Selina", last_name: "Kyle", aka: "Catwoman", convicted_felon: true)
      @bane     = FactoryBot.create(:criminal, first_name: "Edmund", last_name: "Dorrance", aka: "Bane", convicted_felon: true, enhanced_powers: true)
      @maroni   = FactoryBot.create(:criminal, first_name: "Salvatore", last_name: "Maroni", aka: nil)
    end
    
    def destroy_criminals
      @joker.delete
      @catwoman.delete
      @bane.delete
      @maroni.delete
    end
  end
end