class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string :name
      t.boolean :active, default: true

      # t.timestamps
    end
  end
end
