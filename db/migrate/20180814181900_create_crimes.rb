class CreateCrimes < ActiveRecord::Migration[5.1]
  def change
    create_table :crimes do |t|
      t.string :name
      t.boolean :felony, default: true
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
