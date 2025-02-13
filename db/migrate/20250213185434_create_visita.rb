class CreateVisita < ActiveRecord::Migration[7.2]
  def change
    create_table :visita do |t|
      t.integer :idfuncionario
      t.integer :idvisitante
      t.string :foto

      t.timestamps
    end
  end
end
