class CreateCrimeInvestigations < ActiveRecord::Migration[5.1]
  def change
    create_table :crime_investigations do |t|
      t.references :crime, foreign_key: true
      t.references :investigation, foreign_key: true

      # t.timestamps
    end
  end
end
