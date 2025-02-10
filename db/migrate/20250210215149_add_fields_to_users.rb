class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :nome, :string, null: false
    add_column :users, :cpf, :string, null: false
    add_column :users, :telefone, :string
    add_index :users, :cpf, unique: true  # Adicionando a restrição de unicidade corretamente
  end
end
