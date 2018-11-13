class CreateCriminals < ActiveRecord::Migration[5.1]
  def change
    create_table :criminals do |t|
      t.string :first_name
      t.string :last_name
      t.string :aka   # can't use alias because reserved word
      t.boolean :convicted_felon, default: false
      t.boolean :enhanced_powers, default: false
      t.text :notes

      # t.timestamps
    end
  end
end
