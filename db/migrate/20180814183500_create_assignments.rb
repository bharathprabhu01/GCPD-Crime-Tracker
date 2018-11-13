class CreateAssignments < ActiveRecord::Migration[5.1]
  def change
    create_table :assignments do |t|
      t.references :investigation, foreign_key: true
      t.references :officer, foreign_key: true
      t.date :start_date
      t.date :end_date

      # t.timestamps
    end
  end
end
