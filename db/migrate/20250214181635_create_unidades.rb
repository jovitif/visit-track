class CreateUnidades < ActiveRecord::Migration[7.2]
  def change
    create_table :unidades do |t|
      t.string :nome
      t.text :descricao

      t.timestamps
    end
  end
end
