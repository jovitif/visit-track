class AddSetorIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :setor_id, :integer
    add_index :users, :setor_id
  end
end
