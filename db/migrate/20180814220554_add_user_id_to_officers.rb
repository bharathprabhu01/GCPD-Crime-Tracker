class AddUserIdToOfficers < ActiveRecord::Migration[5.1]
  def change
    add_column :officers, :user_id, :integer
  end
end
