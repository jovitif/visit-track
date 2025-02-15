class CreateJoinTableUnidadesSetores < ActiveRecord::Migration[7.2]
  def change
    create_join_table :unidades, :setors do |t|
      t.index :unidade_id
      t.index :setor_id
    end
  end
end
