class CreateSuspects < ActiveRecord::Migration[5.1]
  def change
    create_table :suspects do |t|
      t.references :investigation, foreign_key: true
      t.references :criminal, foreign_key: true
      t.date :added_on
      t.date :dropped_on

      # t.timestamps
    end
  end
end
