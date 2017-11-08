class AddKairosIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :kairos_id, :string
    add_index :users, :kairos_id, unique: true
  end
end
