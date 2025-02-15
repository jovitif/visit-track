class AddUnidadeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_reference :users, :unidade, foreign_key: true
  end
end
