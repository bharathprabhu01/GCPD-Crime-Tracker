class CreateInvestigations < ActiveRecord::Migration[5.1]
  def change
    create_table :investigations do |t|
      t.string :title
      t.text :description
      t.string :crime_location
      t.date :date_opened
      t.date :date_closed
      t.boolean :solved, default: false
      t.boolean :batman_involved, default: false

      # t.timestamps
    end
  end
end
